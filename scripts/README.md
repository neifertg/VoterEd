# Linear Integration Scripts

These scripts allow you to create Linear issues directly from the command line or from JSON files.

## Setup

### 1. Get Your Linear API Key

1. Go to [Linear Settings → API](https://linear.app/settings/api)
2. Click "Create new key" under "Personal API keys"
3. Give it a name (e.g., "VoterEd CLI")
4. Copy the generated key

### 2. Add API Key to Environment

Create or edit `.env.local` in the project root:

```bash
LINEAR_API_KEY=lin_api_xxxxxxxxxxxxxxxxx
```

**Important:** Never commit your `.env.local` file! It's already in `.gitignore`.

## Usage

### Option 1: Create a Single Issue

```bash
node scripts/create-linear-issue.mjs "Issue title" "Issue description"
```

**Example:**
```bash
node scripts/create-linear-issue.mjs "Add navbar component" "Create a responsive navigation bar with logo and links"
```

### Option 2: Create Multiple Issues from JSON

1. Create a JSON file with your issues (see `linear-issues.example.json`)
2. Run the script:

```bash
node scripts/create-issues.mjs your-issues.json
```

**Example JSON format:**
```json
{
  "issues": [
    {
      "title": "Issue title",
      "description": "Detailed description with **markdown** support",
      "priority": 2
    }
  ]
}
```

**Priority levels:**
- `0` = No priority
- `1` = Urgent
- `2` = High
- `3` = Medium
- `4` = Low

### Option 3: Let Claude Create Issues for You

Now Claude can generate the JSON file and run the script for you!

**Example workflow:**
```
You: "Create Linear issues for building a user authentication system"

Claude: [Creates linear-issues.json with appropriate tasks]
Claude: [Runs: node scripts/create-issues.mjs linear-issues.json]

Output:
✅ VOT-5: Implement NextAuth.js setup
✅ VOT-6: Create login page UI
✅ VOT-7: Add password reset flow
🎉 All issues created successfully!
```

## Troubleshooting

### Error: LINEAR_API_KEY not set

Make sure you:
1. Created `.env.local` in the project root
2. Added your API key: `LINEAR_API_KEY=your-key-here`
3. The key starts with `lin_api_`

### Error: No team found

Your Linear workspace needs at least one team. Create one in Linear first.

### Issues created in wrong team

The script uses the first team by default. To specify a team, modify the script or contact your workspace admin.

## Examples

### Create Issues for a Feature

```bash
# Create a file: feature-issues.json
{
  "issues": [
    {
      "title": "Design voting booth UI mockups",
      "description": "Create high-fidelity mockups for the virtual voting booth interface",
      "priority": 2
    },
    {
      "title": "Implement voting booth frontend",
      "description": "Build the React components for the voting booth",
      "priority": 2
    },
    {
      "title": "Add ballot validation logic",
      "description": "Ensure users can't submit invalid ballots",
      "priority": 1
    }
  ]
}

# Run it
node scripts/create-issues.mjs feature-issues.json
```

## Tips

- Use markdown in descriptions for better formatting
- Include acceptance criteria as checklists: `- [ ] Task item`
- Link to design docs or related issues
- Set appropriate priority levels
- Break down large features into smaller issues

## Security Note

**Never commit your LINEAR_API_KEY to Git!**
- It's already in `.gitignore` via `.env*` pattern
- If accidentally committed, revoke the key immediately in Linear settings
