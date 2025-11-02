import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

async function verifyPositions() {
  console.log('Verifying candidate positions...\n');

  // Check total counts
  const { data: allIssues } = await supabase
    .from('issues')
    .select('id, title, locations')
    .not('locations', 'is', null);

  const { data: allPositions } = await supabase
    .from('candidate_positions')
    .select('*');

  console.log(`Total location-specific issues: ${allIssues.length}`);
  console.log(`Total candidate positions: ${allPositions.length}`);

  // Get a sample candidate from Utah (Lehi)
  const { data: utahCandidate } = await supabase
    .from('candidates')
    .select('id, name, office')
    .eq('name', 'Mark Johnson')
    .single();

  if (utahCandidate) {
    console.log(`\n=== Sample: ${utahCandidate.name} (${utahCandidate.office}) ===`);

    const { data: positions } = await supabase
      .from('candidate_positions')
      .select(`
        position,
        issues (title, locations)
      `)
      .eq('candidate_id', utahCandidate.id);

    console.log(`Total positions: ${positions.length}`);
    console.log('\nPositions on location-specific issues:');

    const locationSpecific = positions.filter(p => p.issues?.locations?.length > 0);
    console.log(`  Location-specific: ${locationSpecific.length}`);

    locationSpecific.slice(0, 5).forEach(p => {
      const posLabel = ['', 'Strongly Progressive', 'Somewhat Progressive', 'Neutral', 'Somewhat Conservative', 'Strongly Conservative'][p.position];
      console.log(`    - ${p.issues.title.substring(0, 50)}: ${posLabel} (${p.position})`);
    });
  }

  // Get a sample candidate from Virginia (Loudoun County)
  const { data: vaCandidate } = await supabase
    .from('candidates')
    .select('id, name, office')
    .eq('name', 'John Smith')
    .single();

  if (vaCandidate) {
    console.log(`\n=== Sample: ${vaCandidate.name} (${vaCandidate.office}) ===`);

    const { data: positions } = await supabase
      .from('candidate_positions')
      .select(`
        position,
        issues (title, locations)
      `)
      .eq('candidate_id', vaCandidate.id);

    console.log(`Total positions: ${positions.length}`);
    console.log('\nPositions on location-specific issues:');

    const locationSpecific = positions.filter(p => p.issues?.locations?.length > 0);
    console.log(`  Location-specific: ${locationSpecific.length}`);

    locationSpecific.slice(0, 5).forEach(p => {
      const posLabel = ['', 'Strongly Progressive', 'Somewhat Progressive', 'Neutral', 'Somewhat Conservative', 'Strongly Conservative'][p.position];
      console.log(`    - ${p.issues.title.substring(0, 50)}: ${posLabel} (${p.position})`);
    });
  }

  // Check position distribution for location-specific issues
  console.log('\n=== Position Distribution for Location-Specific Issues ===');

  const positionCounts = { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 };

  for (const issue of allIssues) {
    const { data: issuePositions } = await supabase
      .from('candidate_positions')
      .select('position')
      .eq('issue_id', issue.id);

    issuePositions?.forEach(p => {
      if (p.position >= 1 && p.position <= 5) {
        positionCounts[p.position]++;
      }
    });
  }

  const total = Object.values(positionCounts).reduce((a, b) => a + b, 0);
  console.log(`Total positions on location-specific issues: ${total}`);
  console.log(`  1 (Strongly Progressive): ${positionCounts[1]} (${(positionCounts[1]/total*100).toFixed(1)}%)`);
  console.log(`  2 (Somewhat Progressive): ${positionCounts[2]} (${(positionCounts[2]/total*100).toFixed(1)}%)`);
  console.log(`  3 (Neutral/Moderate): ${positionCounts[3]} (${(positionCounts[3]/total*100).toFixed(1)}%)`);
  console.log(`  4 (Somewhat Conservative): ${positionCounts[4]} (${(positionCounts[4]/total*100).toFixed(1)}%)`);
  console.log(`  5 (Strongly Conservative): ${positionCounts[5]} (${(positionCounts[5]/total*100).toFixed(1)}%)`);
}

verifyPositions();
