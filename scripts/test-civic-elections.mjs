import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const apiKey = process.env.GOOGLE_CIVIC_API_KEY;

console.log('Testing Google Civic API - Elections endpoint');
console.log('API Key:', apiKey ? `${apiKey.substring(0, 10)}...` : 'NOT FOUND');

// Try the elections endpoint first (simpler, doesn't require address)
const electionsUrl = `https://www.googleapis.com/civicinfo/v2/elections?key=${apiKey}`;

console.log('\n=== Testing Elections Endpoint ===');
console.log('URL:', electionsUrl);

try {
  const response = await fetch(electionsUrl);
  const data = await response.json();

  console.log('\nResponse Status:', response.status, response.statusText);
  console.log('Response OK:', response.ok);
  console.log('Response Keys:', Object.keys(data));

  if (data.error) {
    console.log('\nError:', JSON.stringify(data.error, null, 2));
  }

  if (data.elections) {
    console.log('\nElections found:', data.elections.length);
    data.elections.forEach(e => {
      console.log(`  - ${e.name} (${e.electionDay})`);
    });
  }

} catch (error) {
  console.error('Fetch error:', error);
}

// Now try the representatives endpoint with a simple address
console.log('\n\n=== Testing Representatives Endpoint ===');
const address = '1600 Amphitheatre Parkway, Mountain View, CA';
const repUrl = `https://www.googleapis.com/civicinfo/v2/representatives?address=${encodeURIComponent(address)}&key=${apiKey}`;
console.log('URL:', repUrl);

try {
  const response = await fetch(repUrl);
  const data = await response.json();

  console.log('\nResponse Status:', response.status, response.statusText);
  console.log('Response OK:', response.ok);
  console.log('Response Keys:', Object.keys(data));

  if (data.error) {
    console.log('\nError:', JSON.stringify(data.error, null, 2));
  }

  if (data.normalizedInput) {
    console.log('\nnormalizedInput found!');
    console.log(JSON.stringify(data.normalizedInput, null, 2));
  }

  if (data.offices) {
    console.log('\nOffices found:', data.offices.length);
  }

} catch (error) {
  console.error('Fetch error:', error);
}
