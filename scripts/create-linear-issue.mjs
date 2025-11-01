#!/usr/bin/env node
import { LinearClient } from '@linear/sdk';

/**
 * Script to create Linear issues from the command line
 * Usage: node scripts/create-linear-issue.mjs
 */

const LINEAR_API_KEY = process.env.LINEAR_API_KEY;

if (!LINEAR_API_KEY) {
  console.error('❌ Error: LINEAR_API_KEY environment variable not set');
  console.log('\nTo set it up:');
  console.log('1. Go to Linear → Settings → API → Personal API keys');
  console.log('2. Create a new API key');
  console.log('3. Add to your .env.local file: LINEAR_API_KEY=your-key-here');
  console.log('4. Or set temporarily: $env:LINEAR_API_KEY="your-key" (PowerShell)');
  process.exit(1);
}

async function createIssue({ title, description, teamId, priority = 0, labels = [] }) {
  const client = new LinearClient({ apiKey: LINEAR_API_KEY });

  try {
    // Get the team (required for creating issues)
    const teams = await client.teams();
    const team = teamId
      ? teams.nodes.find(t => t.id === teamId)
      : teams.nodes[0]; // Use first team if not specified

    if (!team) {
      throw new Error('No team found. Please specify a valid teamId.');
    }

    // Create the issue
    const issuePayload = await client.createIssue({
      teamId: team.id,
      title,
      description,
      priority,
    });

    const issue = await issuePayload.issue;

    if (issue) {
      console.log('✅ Issue created successfully!');
      console.log(`   Title: ${issue.title}`);
      console.log(`   ID: ${issue.identifier}`);
      console.log(`   URL: ${issue.url}`);
      return issue;
    }
  } catch (error) {
    console.error('❌ Error creating issue:', error.message);
    process.exit(1);
  }
}

// Example usage - modify this or pass arguments
const issueData = {
  title: process.argv[2] || 'Test Issue from Script',
  description: process.argv[3] || 'This issue was created via the Linear SDK script.',
  priority: 2, // 0=No priority, 1=Urgent, 2=High, 3=Medium, 4=Low
};

createIssue(issueData);
