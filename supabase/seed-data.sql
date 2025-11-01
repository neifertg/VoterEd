-- Seed data for VoterEd MVP
-- Focuses on Loudoun County, VA and Lincoln County, NC

-- ============================================================
-- ISSUES (10 key local/state issues)
-- ============================================================

INSERT INTO issues (id, title, slug, description, category) VALUES
  (
    '550e8400-e29b-41d4-a716-446655440001',
    'Education Funding',
    'education-funding',
    'Should the county increase funding for public schools?',
    'local'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440002',
    'Property Tax Rates',
    'property-tax-rates',
    'Should property taxes be increased to fund local services?',
    'local'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440003',
    'Housing Development',
    'housing-development',
    'Should the county approve more residential development?',
    'local'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440004',
    'Public Transportation',
    'public-transportation',
    'Should the county invest more in public transit infrastructure?',
    'local'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440005',
    'Environmental Protection',
    'environmental-protection',
    'Should the county strengthen environmental regulations?',
    'local'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440006',
    'Public Safety Funding',
    'public-safety-funding',
    'Should the county increase funding for police and fire services?',
    'local'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440007',
    'Small Business Support',
    'small-business-support',
    'Should the county provide more tax incentives for small businesses?',
    'local'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440008',
    'Healthcare Access',
    'healthcare-access',
    'Should the state expand Medicaid coverage?',
    'state'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440009',
    'Infrastructure Investment',
    'infrastructure-investment',
    'Should the county invest more in road and bridge repairs?',
    'local'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440010',
    'Zoning Regulations',
    'zoning-regulations',
    'Should the county relax zoning laws to allow mixed-use development?',
    'local'
  );

-- ============================================================
-- SOURCES (Reputable data sources)
-- ============================================================

INSERT INTO sources (id, name, url, source_type, credibility_score, bias_rating) VALUES
  (
    '660e8400-e29b-41d4-a716-446655440001',
    'Ballotpedia',
    'https://ballotpedia.org',
    'nonprofit',
    5,
    'center'
  ),
  (
    '660e8400-e29b-41d4-a716-446655440002',
    'League of Women Voters',
    'https://www.lwv.org',
    'nonprofit',
    5,
    'center'
  ),
  (
    '660e8400-e29b-41d4-a716-446655440003',
    'Loudoun County Government',
    'https://www.loudoun.gov',
    'government',
    5,
    'center'
  ),
  (
    '660e8400-e29b-41d4-a716-446655440004',
    'Lincoln County Government',
    'https://www.lincolncounty.org',
    'government',
    5,
    'center'
  ),
  (
    '660e8400-e29b-41d4-a716-446655440005',
    'Virginia Public Access Project',
    'https://www.vpap.org',
    'nonprofit',
    5,
    'center'
  );

-- ============================================================
-- CANDIDATES (Sample candidates for local races)
-- ============================================================

-- Loudoun County Board of Supervisors candidates
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440001',
    'John Smith',
    'Loudoun County Board of Supervisors - Ashburn District',
    'Republican',
    'Local business owner focused on fiscal responsibility and economic growth.',
    ARRAY['20147', '20148']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440002',
    'Sarah Johnson',
    'Loudoun County Board of Supervisors - Ashburn District',
    'Democrat',
    'Former educator advocating for increased school funding and environmental protection.',
    ARRAY['20147', '20148']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440003',
    'Michael Chen',
    'Loudoun County Board of Supervisors - Sterling District',
    'Independent',
    'Technology professional focused on smart growth and infrastructure.',
    ARRAY['20164', '20165']
  );

-- Lincoln County Commissioner candidates
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440004',
    'Robert Williams',
    'Lincoln County Commissioner',
    'Republican',
    'Small business advocate focused on lower taxes and limited government.',
    ARRAY['28092', '28090']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440005',
    'Jennifer Davis',
    'Lincoln County Commissioner',
    'Democrat',
    'Healthcare worker advocating for expanded services and public education.',
    ARRAY['28092', '28090']
  );

-- ============================================================
-- CANDIDATE POSITIONS (Sample positions on issues)
-- ============================================================

-- John Smith (Loudoun - Republican) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 3, 'Supports education funding at current levels with efficiency improvements', '660e8400-e29b-41d4-a716-446655440001'),
  ('770e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes property tax increases, advocates for spending cuts', '660e8400-e29b-41d4-a716-446655440001'),
  ('770e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports residential development with infrastructure requirements', '660e8400-e29b-41d4-a716-446655440003'),
  ('770e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports tax incentives for small businesses', '660e8400-e29b-41d4-a716-446655440003');

-- Sarah Johnson (Loudoun - Democrat) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports increased education funding', '660e8400-e29b-41d4-a716-446655440001'),
  ('770e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', 4, 'Supports modest tax increases for essential services', '660e8400-e29b-41d4-a716-446655440001'),
  ('770e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports environmental protections', '660e8400-e29b-41d4-a716-446655440003'),
  ('770e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440004', 4, 'Supports expanded public transportation', '660e8400-e29b-41d4-a716-446655440003');

-- Michael Chen (Loudoun - Independent) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', 3, 'Supports balanced approach to development', '660e8400-e29b-41d4-a716-446655440001'),
  ('770e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports infrastructure investment', '660e8400-e29b-41d4-a716-446655440001'),
  ('770e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440010', 4, 'Supports mixed-use zoning reforms', '660e8400-e29b-41d4-a716-446655440003');

-- Robert Williams (Lincoln - Republican) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', 1, 'Strongly opposes tax increases', '660e8400-e29b-41d4-a716-446655440002'),
  ('770e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports small business incentives', '660e8400-e29b-41d4-a716-446655440004'),
  ('770e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440008', 2, 'Opposes Medicaid expansion', '660e8400-e29b-41d4-a716-446655440002');

-- Jennifer Davis (Lincoln - Democrat) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports education funding increases', '660e8400-e29b-41d4-a716-446655440002'),
  ('770e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440008', 5, 'Strongly supports Medicaid expansion', '660e8400-e29b-41d4-a716-446655440004'),
  ('770e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440006', 4, 'Supports increased public safety funding', '660e8400-e29b-41d4-a716-446655440004');
