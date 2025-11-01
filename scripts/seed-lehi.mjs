#!/usr/bin/env node

/**
 * Seed Lehi, Utah data into Supabase
 * Adds candidates and positions for Lehi City Council races
 */

import { createClient } from '@supabase/supabase-js';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config({ path: '.env.local' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing Supabase credentials in .env.local');
  console.error('Make sure NEXT_PUBLIC_SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY are set');
  process.exit(1);
}

// Use service role key to bypass RLS policies
const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function seedLehiData() {
  console.log('🌱 Starting Lehi data seeding...\n');

  try {
    // Read the SQL file
    const sqlPath = join(__dirname, '..', 'supabase', 'seed-data-lehi.sql');
    const sqlContent = readFileSync(sqlPath, 'utf-8');

    // Split by INSERT statements and execute them individually
    const statements = sqlContent
      .split(/INSERT INTO/)
      .filter(stmt => stmt.trim().length > 0)
      .map(stmt => 'INSERT INTO' + stmt);

    console.log(`📝 Found ${statements.length} SQL statements to execute\n`);

    // Execute each statement
    for (let i = 0; i < statements.length; i++) {
      const statement = statements[i].trim();
      if (!statement) continue;

      // Extract table name for logging
      const tableMatch = statement.match(/INSERT INTO\s+(\w+)/);
      const tableName = tableMatch ? tableMatch[1] : 'unknown';

      console.log(`⏳ Executing statement ${i + 1}/${statements.length} (${tableName})...`);

      // For sources
      if (tableName === 'sources') {
        // Parse and insert sources manually
        const sourceMatches = statement.matchAll(/\(\s*'([^']+)',\s*'([^']+)',\s*'([^']+)',\s*'([^']+)',\s*(\d+),\s*'([^']+)'\s*\)/g);

        for (const match of sourceMatches) {
          const [, id, name, url, source_type, credibility_score, bias_rating] = match;
          const { error } = await supabase.from('sources').insert({
            id,
            name,
            url,
            source_type,
            credibility_score: parseInt(credibility_score),
            bias_rating
          });

          if (error && !error.message.includes('duplicate')) {
            console.error(`  ⚠️  Warning for source "${name}":`, error.message);
          } else if (!error) {
            console.log(`  ✓ Inserted source: ${name}`);
          } else {
            console.log(`  ℹ️  Source already exists: ${name}`);
          }
        }
      }

      // For candidates
      else if (tableName === 'candidates') {
        const candidateMatches = statement.matchAll(/\(\s*'([^']+)',\s*'([^']+)',\s*'([^']+)',\s*'([^']+)',\s*'([^']+)',\s*ARRAY\[([^\]]+)\]\s*\)/g);

        for (const match of candidateMatches) {
          const [, id, name, office, party, bio, zipCodesStr] = match;
          const zip_codes = zipCodesStr.split(',').map(z => z.trim().replace(/'/g, ''));

          const { error } = await supabase.from('candidates').insert({
            id,
            name,
            office,
            party,
            bio,
            zip_codes
          });

          if (error && !error.message.includes('duplicate')) {
            console.error(`  ⚠️  Warning for candidate "${name}":`, error.message);
          } else if (!error) {
            console.log(`  ✓ Inserted candidate: ${name}`);
          } else {
            console.log(`  ℹ️  Candidate already exists: ${name}`);
          }
        }
      }

      // For candidate_positions
      else if (tableName === 'candidate_positions') {
        const positionMatches = statement.matchAll(/\('([^']+)',\s*'([^']+)',\s*(\d+),\s*'([^']+)',\s*'([^']+)'\)/g);

        for (const match of positionMatches) {
          const [, candidate_id, issue_id, position, position_text, source_id] = match;

          const { error } = await supabase.from('candidate_positions').insert({
            candidate_id,
            issue_id,
            position: parseInt(position),
            position_text,
            source_id
          });

          if (error && !error.message.includes('duplicate')) {
            console.error(`  ⚠️  Warning for position:`, error.message);
          } else if (!error) {
            console.log(`  ✓ Inserted position for candidate`);
          } else {
            console.log(`  ℹ️  Position already exists`);
          }
        }
      }
    }

    console.log('\n✅ Lehi data seeding completed!');
    console.log('\n📊 Summary:');
    console.log('  - Added 2 Utah sources');
    console.log('  - Added 5 Lehi City Council candidates');
    console.log('  - Added candidate positions on local issues');
    console.log('  - Zip codes covered: 84003, 84005, 84043');

  } catch (error) {
    console.error('❌ Error seeding Lehi data:', error);
    process.exit(1);
  }
}

seedLehiData();
