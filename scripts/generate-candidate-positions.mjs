import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

// Map zip codes to state codes
const zipToState = {
  '84043': 'UT', '84003': 'UT', '84005': 'UT',
  '20147': 'VA', '20148': 'VA', '20164': 'VA', '20165': 'VA',
  '77449': 'TX', '77450': 'TX', '77493': 'TX',
  '08204': 'NJ', '08210': 'NJ', '08260': 'NJ',
  '67002': 'KS',
  '49614': 'MI',
  '28090': 'NC', '28092': 'NC',
  '68847': 'NE'
};

// Generate a position based on candidate name and issue
// This creates variety while being deterministic
function generatePosition(candidateName, issueTitle, issueId) {
  // Use simple hash of candidate name + issue id to generate consistent but varied positions
  const hashStr = candidateName + issueId;
  let hash = 0;
  for (let i = 0; i < hashStr.length; i++) {
    hash = ((hash << 5) - hash) + hashStr.charCodeAt(i);
    hash = hash & hash;
  }

  // Map to positions 1-5 with more variety in middle ranges
  const abs = Math.abs(hash);
  const mod = abs % 100;

  if (mod < 15) return 1; // Strongly Progressive
  if (mod < 40) return 2; // Somewhat Progressive
  if (mod < 60) return 3; // Neutral/Moderate
  if (mod < 85) return 4; // Somewhat Conservative
  return 5; // Strongly Conservative
}

async function generatePositions() {
  console.log('Fetching candidates and location-specific issues...');

  // Get all candidates with their locations
  const { data: candidates, error: cError } = await supabase
    .from('candidates')
    .select('id, name, office, zip_codes')
    .order('name');

  if (cError) {
    console.error('Error fetching candidates:', cError);
    return;
  }

  // Get all location-specific issues
  const { data: issues, error: iError } = await supabase
    .from('issues')
    .select('id, title, locations')
    .not('locations', 'is', null)
    .order('id');

  if (iError) {
    console.error('Error fetching issues:', iError);
    return;
  }

  console.log(`Found ${candidates.length} candidates and ${issues.length} location-specific issues`);

  // Generate all candidate-issue matches
  const positions = [];
  let matchCount = 0;

  candidates.forEach(candidate => {
    // Get the states for this candidate's zip codes
    const candidateStates = new Set();
    candidate.zip_codes?.forEach(zip => {
      const state = zipToState[zip];
      if (state) candidateStates.add(state);
    });

    issues.forEach(issue => {
      // Check if any of the candidate's states match the issue locations
      const hasMatch = issue.locations.some(loc => candidateStates.has(loc));

      if (hasMatch) {
        const position = generatePosition(candidate.name, issue.title, issue.id);
        positions.push({
          candidate_id: candidate.id,
          issue_id: issue.id,
          position: position
        });
        matchCount++;
      }
    });
  });

  console.log(`\nGenerated ${positions.length} candidate positions`);

  // Count positions by value
  const positionCounts = { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 };
  positions.forEach(p => positionCounts[p.position]++);
  console.log('\nPosition distribution:');
  console.log(`  1 (Strongly Progressive): ${positionCounts[1]} (${(positionCounts[1]/positions.length*100).toFixed(1)}%)`);
  console.log(`  2 (Somewhat Progressive): ${positionCounts[2]} (${(positionCounts[2]/positions.length*100).toFixed(1)}%)`);
  console.log(`  3 (Neutral/Moderate): ${positionCounts[3]} (${(positionCounts[3]/positions.length*100).toFixed(1)}%)`);
  console.log(`  4 (Somewhat Conservative): ${positionCounts[4]} (${(positionCounts[4]/positions.length*100).toFixed(1)}%)`);
  console.log(`  5 (Strongly Conservative): ${positionCounts[5]} (${(positionCounts[5]/positions.length*100).toFixed(1)}%)`);

  // Insert positions in batches of 100
  console.log('\nInserting positions into database...');
  const batchSize = 100;
  let inserted = 0;
  let errors = 0;

  for (let i = 0; i < positions.length; i += batchSize) {
    const batch = positions.slice(i, i + batchSize);
    const { error } = await supabase
      .from('candidate_positions')
      .insert(batch);

    if (error) {
      console.error(`Error inserting batch ${i / batchSize + 1}:`, error.message);
      errors++;
    } else {
      inserted += batch.length;
      process.stdout.write(`\rInserted ${inserted} / ${positions.length} positions...`);
    }
  }

  console.log(`\n\nComplete! Inserted ${inserted} positions with ${errors} errors.`);
}

generatePositions();
