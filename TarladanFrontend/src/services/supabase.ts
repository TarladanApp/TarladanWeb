import { createClient } from '@supabase/supabase-js';

// URL ve anahtarı doğrudan tanımlayalım
const supabaseUrl = 'https://lenywutixaktnyltvbnt.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxlbnl3dXRpeGFrdG55bHR2Ym50Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUxNzQ4NjksImV4cCI6MjA2MDc1MDg2OX0.qTDUh7k2Ov1qf5HsmvEyJREAEXR1DWUfAk8yAqExs';

// URL'yi validate et
console.log('Supabase URL:', supabaseUrl);
console.log('Supabase Key ilk 20 karakter:', supabaseKey.substring(0, 20));

try {
  // URL'nin geçerli olup olmadığını kontrol et
  new URL(supabaseUrl);
  console.log('URL geçerli');
} catch (error) {
  console.error('URL geçersiz:', error);
  throw new Error('Geçersiz Supabase URL');
}

// Client'ı oluştur
let supabase;
try {
  supabase = createClient(supabaseUrl, supabaseKey);
  console.log('Supabase client başarıyla oluşturuldu');
} catch (error: any) {
  console.error('Supabase client oluşturulurken hata:', error);
  throw new Error('Supabase client oluşturulamadı: ' + (error?.message || 'Bilinmeyen hata'));
}

export { supabase }; 