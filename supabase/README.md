# Supabase Database Setup

This directory contains the database schema and migrations for VoterEd.

## Initial Setup

### Option 1: Run SQL in Supabase Dashboard (Easiest)

1. Go to your Supabase project: https://supabase.com/dashboard/project/yevltknwdqwekgnjbufo
2. Click "SQL Editor" in the left sidebar
3. Click "New query"
4. Copy the contents of `migrations/001_initial_schema.sql`
5. Paste into the SQL editor
6. Click "Run" (or press Cmd/Ctrl + Enter)
7. You should see "Success. No rows returned"

### Option 2: Use Supabase CLI (Advanced)

```bash
# Install Supabase CLI
npm install -g supabase

# Login
supabase login

# Link to your project
supabase link --project-ref yevltknwdqwekgnjbufo

# Run migration
supabase db push
```

## Database Schema

### Tables

1. **users** - User profiles with zip code
2. **issues** - Political issues (education, healthcare, etc.)
3. **user_issue_preferences** - User's stance and importance on each issue
4. **sources** - Tracking data sources and credibility
5. **candidates** - Candidate information
6. **candidate_positions** - Candidate positions on each issue
7. **issue_explanations** - Unbiased explanations of issues

### Relationships

```
users (1) ──→ (many) user_issue_preferences
issues (1) ──→ (many) user_issue_preferences
issues (1) ──→ (many) candidate_positions
candidates (1) ──→ (many) candidate_positions
sources (1) ──→ (many) candidate_positions
issues (1) ──→ (many) issue_explanations
```

## Verifying the Setup

After running the migration, verify it worked:

1. Go to Supabase Dashboard → Table Editor
2. You should see 7 tables:
   - users
   - issues
   - user_issue_preferences
   - sources
   - candidates
   - candidate_positions
   - issue_explanations

## Next Steps

After setting up the schema:
1. Seed the database with sample data (see `../scripts/seed-database.ts`)
2. Test the connection from your Next.js app
3. Start building the quiz and results features!

## Troubleshooting

**Error: "extension uuid-ossp does not exist"**
- This should be automatically available in Supabase
- If not, contact Supabase support

**Error: "permission denied"**
- Make sure you're logged in as the project owner
- Check that you're using the correct project

**Tables don't appear**
- Refresh the browser
- Check the SQL editor for error messages
- Make sure the migration ran successfully
