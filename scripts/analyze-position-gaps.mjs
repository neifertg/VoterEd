import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

// Map zip codes to state codes
const zipToState = {
  '84043': 'UT',
  '20147': 'VA',
  '77449': 'TX',
  '08204': 'NJ',
  '67002': 'KS',
  '49614': 'MI',
  '68847': 'NE'
};

async function analyzeData() {
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

  console.log('\n=== CANDIDATES BY LOCATION ===');
  const locationMap = {};
  candidates.forEach(c => {
    c.zip_codes?.forEach(zip => {
      if (!locationMap[zip]) locationMap[zip] = [];
      locationMap[zip].push({ name: c.name, office: c.office, id: c.id });
    });
  });

  Object.keys(locationMap).sort().forEach(zip => {
    const state = zipToState[zip] || 'Unknown';
    console.log(`\n${zip} (${state}):`);
    locationMap[zip].forEach(c => console.log(`  - ${c.name} (${c.office}) [ID: ${c.id}]`));
  });

  console.log('\n\n=== LOCATION-SPECIFIC ISSUES ===');
  issues.forEach(issue => {
    console.log(`\nIssue ${issue.id}: ${issue.title}`);
    console.log(`  Locations: ${issue.locations.join(', ')}`);
  });

  console.log('\n\n=== MATCHING CANDIDATES TO ISSUES ===');
  const matches = [];

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
        matches.push({
          candidate_id: candidate.id,
          candidate_name: candidate.name,
          issue_id: issue.id,
          issue_title: issue.title.substring(0, 50),
          locations: issue.locations
        });
      }
    });
  });

  console.log(`\n\nTotal candidate-issue matches to create: ${matches.length}`);
  console.log('\nFirst 20 matches:');
  matches.slice(0, 20).forEach(m => {
    console.log(`  ${m.candidate_name} -> ${m.issue_title} (${m.locations.join(', ')})`);
  });

  // Group by state
  console.log('\n\n=== MATCHES BY STATE ===');
  const byState = {};
  matches.forEach(m => {
    m.locations.forEach(loc => {
      if (!byState[loc]) byState[loc] = 0;
      byState[loc]++;
    });
  });

  Object.keys(byState).sort().forEach(state => {
    console.log(`${state}: ${byState[state]} candidate-issue pairs`);
  });
}

analyzeData();
