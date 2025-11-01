-- VoterEd Database Schema
-- This creates all the tables needed for the MVP

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- USERS TABLE
-- ============================================================
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  zip_code VARCHAR(10) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================
-- ISSUES TABLE
-- ============================================================
CREATE TABLE issues (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,
  description TEXT,
  category VARCHAR(50) NOT NULL, -- 'local', 'state', 'federal'
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================
-- USER ISSUE PREFERENCES TABLE
-- ============================================================
CREATE TABLE user_issue_preferences (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  issue_id UUID NOT NULL REFERENCES issues(id) ON DELETE CASCADE,
  stance INTEGER NOT NULL CHECK (stance >= 1 AND stance <= 5), -- 1=Strongly Disagree, 5=Strongly Agree
  importance INTEGER DEFAULT 3 CHECK (importance >= 1 AND importance <= 5), -- 1=Low, 5=High
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, issue_id)
);

-- ============================================================
-- SOURCES TABLE
-- ============================================================
CREATE TABLE sources (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  url TEXT NOT NULL,
  source_type VARCHAR(50) NOT NULL, -- 'government', 'news', 'nonprofit', 'campaign', 'other'
  credibility_score INTEGER DEFAULT 3 CHECK (credibility_score >= 1 AND credibility_score <= 5),
  bias_rating VARCHAR(50), -- 'left', 'center-left', 'center', 'center-right', 'right', 'unknown'
  last_verified_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================
-- CANDIDATES TABLE
-- ============================================================
CREATE TABLE candidates (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  office VARCHAR(255) NOT NULL,
  party VARCHAR(100),
  bio TEXT,
  website_url TEXT,
  photo_url TEXT,
  zip_codes TEXT[], -- Array of zip codes where this candidate is running
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================
-- CANDIDATE POSITIONS TABLE
-- ============================================================
CREATE TABLE candidate_positions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  candidate_id UUID NOT NULL REFERENCES candidates(id) ON DELETE CASCADE,
  issue_id UUID NOT NULL REFERENCES issues(id) ON DELETE CASCADE,
  position INTEGER CHECK (position >= 1 AND position <= 5), -- 1=Strongly Disagree, 5=Strongly Agree
  position_text TEXT, -- Candidate's stated position in their own words
  source_id UUID REFERENCES sources(id),
  source_url TEXT,
  last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(candidate_id, issue_id)
);

-- ============================================================
-- ISSUE EXPLANATIONS TABLE
-- ============================================================
CREATE TABLE issue_explanations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  issue_id UUID NOT NULL REFERENCES issues(id) ON DELETE CASCADE,
  explanation TEXT NOT NULL,
  viewpoint VARCHAR(50), -- 'overview', 'perspective_1', 'perspective_2', etc.
  source_ids UUID[], -- Array of source IDs
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================

-- User lookups by zip code
CREATE INDEX idx_users_zip_code ON users(zip_code);

-- Issue lookups
CREATE INDEX idx_issues_category ON issues(category);
CREATE INDEX idx_issues_slug ON issues(slug);

-- User preference lookups
CREATE INDEX idx_user_prefs_user_id ON user_issue_preferences(user_id);
CREATE INDEX idx_user_prefs_issue_id ON user_issue_preferences(issue_id);

-- Candidate lookups
CREATE INDEX idx_candidates_office ON candidates(office);
CREATE INDEX idx_candidates_party ON candidates(party);
CREATE INDEX idx_candidates_zip_codes ON candidates USING GIN(zip_codes);

-- Candidate position lookups
CREATE INDEX idx_candidate_positions_candidate_id ON candidate_positions(candidate_id);
CREATE INDEX idx_candidate_positions_issue_id ON candidate_positions(issue_id);

-- Issue explanation lookups
CREATE INDEX idx_issue_explanations_issue_id ON issue_explanations(issue_id);

-- ============================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ============================================================

-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_issue_preferences ENABLE ROW LEVEL SECURITY;
ALTER TABLE issues ENABLE ROW LEVEL SECURITY;
ALTER TABLE sources ENABLE ROW LEVEL SECURITY;
ALTER TABLE candidates ENABLE ROW LEVEL SECURITY;
ALTER TABLE candidate_positions ENABLE ROW LEVEL SECURITY;
ALTER TABLE issue_explanations ENABLE ROW LEVEL SECURITY;

-- Public read access for reference data
CREATE POLICY "Issues are publicly readable"
  ON issues FOR SELECT
  USING (true);

CREATE POLICY "Candidates are publicly readable"
  ON candidates FOR SELECT
  USING (true);

CREATE POLICY "Candidate positions are publicly readable"
  ON candidate_positions FOR SELECT
  USING (true);

CREATE POLICY "Sources are publicly readable"
  ON sources FOR SELECT
  USING (true);

CREATE POLICY "Issue explanations are publicly readable"
  ON issue_explanations FOR SELECT
  USING (true);

-- User data policies (for now, allow all operations for anonymous users)
-- TODO: Add proper auth policies when we implement user accounts
CREATE POLICY "Users can insert their own data"
  ON users FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Users can read their own data"
  ON users FOR SELECT
  USING (true);

CREATE POLICY "Users can insert their preferences"
  ON user_issue_preferences FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Users can read their preferences"
  ON user_issue_preferences FOR SELECT
  USING (true);

CREATE POLICY "Users can update their preferences"
  ON user_issue_preferences FOR UPDATE
  USING (true);

-- ============================================================
-- FUNCTIONS
-- ============================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Add triggers to auto-update updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_issues_updated_at BEFORE UPDATE ON issues
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_user_prefs_updated_at BEFORE UPDATE ON user_issue_preferences
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_sources_updated_at BEFORE UPDATE ON sources
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_candidates_updated_at BEFORE UPDATE ON candidates
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_issue_explanations_updated_at BEFORE UPDATE ON issue_explanations
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
