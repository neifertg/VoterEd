-- Expanded Lehi, Utah data - Multiple offices
-- Provides comprehensive ballot coverage for all local/state races

-- ============================================================
-- ADDITIONAL CANDIDATES - Multiple Offices for Lehi, Utah
-- ============================================================

-- MAYOR
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440011',
    'Mark Johnson',
    'Lehi Mayor',
    'Republican',
    'Current city councilmember with 8 years experience managing rapid growth and infrastructure development.',
    ARRAY['84003', '84005', '84043']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440012',
    'Sarah Williams',
    'Lehi Mayor',
    'Republican',
    'Business executive focused on economic development, public safety, and maintaining quality of life during growth.',
    ARRAY['84003', '84005', '84043']
  );

-- SCHOOL BOARD (Alpine School District)
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440013',
    'Jessica Brown',
    'Alpine School Board - District 7',
    'Non-partisan',
    'Parent and former teacher advocating for increased teacher pay, smaller class sizes, and curriculum transparency.',
    ARRAY['84003', '84005', '84043']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440014',
    'Robert Taylor',
    'Alpine School Board - District 7',
    'Non-partisan',
    'Education administrator focused on fiscal responsibility, academic excellence, and parent choice.',
    ARRAY['84003', '84005', '84043']
  );

-- STATE HOUSE
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440015',
    'Daniel Garcia',
    'Utah House District 54',
    'Republican',
    'Small business owner advocating for lower taxes, less regulation, and educational freedom.',
    ARRAY['84043']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440016',
    'Michelle Lee',
    'Utah House District 54',
    'Democrat',
    'Healthcare professional focused on Medicaid expansion, clean air initiatives, and education funding.',
    ARRAY['84043']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440017',
    'Steven Clark',
    'Utah House District 53',
    'Republican',
    'Engineer and community leader focused on infrastructure, water conservation, and responsible growth.',
    ARRAY['84003', '84005']
  );

-- STATE SENATE
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440018',
    'Jennifer Martinez',
    'Utah Senate District 14',
    'Republican',
    'Incumbent senator with focus on economic development, education choice, and fiscal conservatism.',
    ARRAY['84003', '84005', '84043']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440019',
    'Thomas Anderson',
    'Utah Senate District 14',
    'Democrat',
    'Attorney advocating for healthcare access, environmental protection, and public education investment.',
    ARRAY['84003', '84005', '84043']
  );

-- ============================================================
-- CANDIDATE POSITIONS - All new candidates
-- ============================================================

-- Mark Johnson (Mayor) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports education funding to match population growth', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440002', 3, 'Supports modest tax increases only for critical infrastructure', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports strategic development with impact fees', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440006', 5, 'Strongly supports public safety as top priority', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports infrastructure investment for growth', '660e8400-e29b-41d4-a716-446655440006');

-- Sarah Williams (Mayor) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes tax increases, focuses on efficiency', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440003', 3, 'Supports controlled development with quality standards', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440006', 5, 'Strongly supports police and fire department funding', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports business incentives and job growth', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440009', 4, 'Supports infrastructure but seeks private partnerships', '660e8400-e29b-41d4-a716-446655440006');

-- Jessica Brown (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports increased education funding and teacher pay', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440002', 4, 'Supports tax increases specifically for education', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440005', 4, 'Supports environmental education and green initiatives', '660e8400-e29b-41d4-a716-446655440007');

-- Robert Taylor (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports education funding with accountability measures', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440002', 3, 'Supports maintaining current funding levels efficiently', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440007', 4, 'Supports business partnerships in education', '660e8400-e29b-41d4-a716-446655440007');

-- Daniel Garcia (State House 54) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440001', 3, 'Supports education funding through growth, not new taxes', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440002', 1, 'Strongly opposes tax increases', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports tax cuts for small businesses', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440008', 2, 'Opposes Medicaid expansion', '660e8400-e29b-41d4-a716-446655440007');

-- Michelle Lee (State House 54) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports increased education funding', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports environmental protection and clean air', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440008', 5, 'Strongly supports Medicaid expansion', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440004', 4, 'Supports public transportation expansion', '660e8400-e29b-41d4-a716-446655440007');

-- Steven Clark (State House 53) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports responsible development with infrastructure', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440005', 3, 'Supports balanced environmental approach', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports water and road infrastructure', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes unnecessary tax increases', '660e8400-e29b-41d4-a716-446655440007');

-- Jennifer Martinez (State Senate 14) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports school choice and charter school expansion', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes broad tax increases', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports business-friendly policies', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440008', 2, 'Opposes Medicaid expansion', '660e8400-e29b-41d4-a716-446655440007');

-- Thomas Anderson (State Senate 14) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports public education investment', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports environmental protection', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440008', 5, 'Strongly supports healthcare access and Medicaid', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440004', 5, 'Strongly supports public transit investment', '660e8400-e29b-41d4-a716-446655440007');

-- Add ON CONFLICT clauses to prevent duplicates
