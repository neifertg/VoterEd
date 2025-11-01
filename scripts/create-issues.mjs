#!/usr/bin/env node
import { LinearClient } from '@linear/sdk';
import { readFileSync } from 'fs';
import { config } from 'dotenv';

// Load environment variables from .env.local
config({ path: '.env.local' });

/**
 * Script to create multiple Linear issues from a JSON file
 * Usage: node scripts/create-issues.mjs issues.json
 */

const LINEAR_API_KEY = process.env.LINEAR_API_KEY;

if (!LINEAR_API_KEY) {
  console.error('❌ Error: LINEAR_API_KEY environment variable not set');
  console.log('\nTo set it up:');
  console.log('1. Go to Linear → Settings → API → Personal API keys');
  console.log('2. Create a new API key');
  console.log('3. Add LINEAR_API_KEY=your-key to .env.local');
  process.exit(1);
}

async function createIssues(issuesFile) {
  const client = new LinearClient({ apiKey: LINEAR_API_KEY });

  try {
    // Read issues from file
    const issuesData = JSON.parse(readFileSync(issuesFile, 'utf8'));

    // Get the first team
    const teams = await client.teams();
    const team = teams.nodes[0];

    if (!team) {
      throw new Error('No team found in Linear workspace.');
    }

    console.log(`📋 Creating ${issuesData.issues.length} issues in team: ${team.name}\n`);

    // Create each issue
    for (const issueData of issuesData.issues) {
      const issuePayload = await client.createIssue({
        teamId: team.id,
        title: issueData.title,
        description: issueData.description,
        priority: issueData.priority || 0,
      });

      const issue = await issuePayload.issue;

      if (issue) {
        console.log(`✅ ${issue.identifier}: ${issue.title}`);
        console.log(`   URL: ${issue.url}\n`);
      }
    }

    console.log('🎉 All issues created successfully!');
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

const issuesFile = process.argv[2] || 'linear-issues.json';
createIssues(issuesFile);
