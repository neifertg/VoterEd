#!/usr/bin/env node

/**
 * Seed expanded Lehi, Utah data - Multiple offices
 */

import { createClient } from '@supabase/supabase-js';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing Supabase credentials');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

const sqlPath = join(__dirname, '..', 'supabase', 'seed-data-lehi-expanded.sql');
const sqlContent = readFileSync(sqlPath, 'utf-8');

console.log('🌱 Seeding expanded Lehi data (multiple offices)...\n');

// Execute via Supabase RPC
const statements = sqlContent
  .split('INSERT INTO')
  .filter(s => s.trim())
  .map(s => 'INSERT INTO' + s);

for (const stmt of statements) {
  console.log(stmt.substring(0, 50) + '...');
}

console.log('\n✅ Please run the SQL file manually in Supabase SQL Editor');
console.log('📂 File location: supabase/seed-data-lehi-expanded.sql\n');
