-- Seed data for Lehi, Utah
-- Adds candidates and positions for Lehi City Council races

-- ============================================================
-- SOURCES (Add Utah-specific sources)
-- ============================================================

INSERT INTO sources (id, name, url, source_type, credibility_score, bias_rating) VALUES
  (
    '660e8400-e29b-41d4-a716-446655440006',
    'Lehi City Government',
    'https://www.lehi-ut.gov',
    'government',
    5,
    'center'
  ),
  (
    '660e8400-e29b-41d4-a716-446655440007',
    'Utah League of Cities and Towns',
    'https://www.ulct.org',
    'nonprofit',
    5,
    'center'
  );

-- ============================================================
-- CANDIDATES (Lehi City Council)
-- ============================================================

-- Lehi City Council candidates (all Lehi zip codes: 84003, 84005, 84043)
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440006',
    'David Martinez',
    'Lehi City Council - At Large',
    'Republican',
    'Tech entrepreneur focused on managing rapid growth while preserving community character and keeping taxes low.',
    ARRAY['84003', '84005', '84043']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440007',
    'Emily Thompson',
    'Lehi City Council - At Large',
    'Republican',
    'Former teacher and current planning commission member advocating for smart growth and improved infrastructure.',
    ARRAY['84003', '84005', '84043']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440008',
    'James Anderson',
    'Lehi City Council - District 1',
    'Republican',
    'Small business owner focused on economic development and supporting local businesses while managing growth.',
    ARRAY['84043']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440009',
    'Lisa Peterson',
    'Lehi City Council - District 1',
    'Independent',
    'Community advocate prioritizing public safety, parks and recreation, and sustainable development.',
    ARRAY['84043']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440010',
    'Ryan Mitchell',
    'Lehi City Council - District 2',
    'Republican',
    'Engineer with focus on infrastructure improvements, traffic solutions, and responsible fiscal management.',
    ARRAY['84003', '84005']
  );

-- ============================================================
-- CANDIDATE POSITIONS (Lehi candidates on existing issues)
-- ============================================================

-- David Martinez (Lehi - Republican, At Large) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports education funding increases to keep pace with rapid growth', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes property tax increases, prefers to use growth revenue', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', 3, 'Supports controlled residential development with adequate infrastructure', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports incentives for tech and small businesses', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440009', 4, 'Supports infrastructure investment, especially for traffic', '660e8400-e29b-41d4-a716-446655440006');

-- Emily Thompson (Lehi - Republican, At Large) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports increased education funding for growing schools', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports strategic development with parks and green space requirements', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440004', 4, 'Supports public transit expansion for growing community', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440005', 4, 'Supports environmental protections while allowing growth', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports road improvements and traffic solutions', '660e8400-e29b-41d4-a716-446655440006');

-- James Anderson (Lehi - Republican, District 1) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes tax increases, supports economic growth to increase revenue', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports development that brings jobs and commercial growth', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports small business development and incentives', '660e8400-e29b-41d4-a716-446655440007'),
  ('770e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440010', 4, 'Supports mixed-use development for economic vitality', '660e8400-e29b-41d4-a716-446655440006');

-- Lisa Peterson (Lehi - Independent, District 1) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440003', 3, 'Supports balanced development with adequate parks and amenities', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports environmental protections and green space', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440006', 5, 'Strongly supports public safety funding for growing city', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440009', 4, 'Supports infrastructure investment for roads and utilities', '660e8400-e29b-41d4-a716-446655440006');

-- Ryan Mitchell (Lehi - Republican, District 2) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes property tax hikes, focuses on efficiency', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports development with proper infrastructure planning', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports infrastructure investment, especially roads and water', '660e8400-e29b-41d4-a716-446655440006'),
  ('770e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440010', 4, 'Supports updated zoning for better traffic flow and growth management', '660e8400-e29b-41d4-a716-446655440006');
