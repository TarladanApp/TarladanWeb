import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.REACT_APP_SUPABASE_URL || 'https://lenywutixaktnyltvbnt.supabase.co';
const supabaseKey = process.env.REACT_APP_SUPABASE_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxlbnl3dXRpeGFrdG55bHR2Ym50Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUxNzQ4NjksImV4cCI6MjA2MDc1MDg2OX0.qTDUh57k52Ov1qf5HsmvEyJREAEXR1DWUfAk8yAqExs';

if (!supabaseUrl || !supabaseKey) {
  throw new Error('Supabase URL ve Key değerleri eksik!');
}

export const supabase = createClient(supabaseUrl, supabaseKey); 