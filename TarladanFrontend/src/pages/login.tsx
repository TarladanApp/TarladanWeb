import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { loginFarmer } from '../services/api';

export default function Login() {
  const [form, setForm] = useState({
    identifier: '',
    password: '',
  });
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [submitError, setSubmitError] = useState('');
  const navigate = useNavigate();

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setForm({ ...form, [name]: value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitError('');
    setIsLoading(true);
    try {
      // 'identifier' alanını e-posta olarak varsayıyoruz.
      // Eğer hem e-posta hem telefon ile giriş gerekiyorsa backend'de ayrı bir doğrulama yapılmalı.
      const response = await loginFarmer({
        farmer_mail: form.identifier,
        farmer_password: form.password,
      });

      if (response.success) {
        alert('Giriş başarılı!');
        // Başarılı girişte Supabase Auth session'ı otomatik yönetir.
        // Frontend'de kullanıcı bilgilerini veya session'ı saklamak için Context API vb. kullanılabilir.
    navigate('/dashboard');
      } else {
        setSubmitError(response.message || 'Giriş işlemi başarısız oldu');
      }
    } catch (error: any) {
      setSubmitError(error.message || 'Bir hata oluştu.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div
      style={{
        width: '100vw',
        height: '100vh',
        background: '#698B69',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent:'center',
      }}
    >
      <img
        src={require('../assets/brand-logo.png')}
        alt="Logo"
        style={{ width: 70, marginBottom: 18 , marginTop: -140,}}
      />
      <h1 style={{ color: '#fff', fontWeight: 800, fontSize: 38, marginBottom: 0, letterSpacing: 1, textAlign: 'center', textShadow: '0 2px 8px #0004' }}>
        TARLADANA HOŞ GELDİNİZ
      </h1>
      <p style={{ color: '#f8faf3', marginTop: 20, marginBottom: 10, fontWeight: 500, fontSize: 18, textAlign: 'center' }}>
        Ürünlerinizi Yükleyip Çİftliğinizi Yönetin
      </p>
      <p
        onClick={() => window.location.href = '/register'}
        style={{
          color: '#b6ffb6',
          marginTop: 0,
          marginBottom: 32,
          fontWeight: 500,
          fontSize: 18,
          textAlign: 'center',
          cursor: 'pointer',
          textDecoration: 'underline',
          transition: 'color 0.2s',
        }}
        title="Kayıt sayfasına git"
      >
        Kayıt Ol
      </p>
      <form
        onSubmit={handleSubmit}
        style={{
          background: '#f8faf3',
          padding: 36,
          borderRadius: 24,
          minWidth: 340,
          maxWidth: 400,
          boxShadow: '0 6px 32px #00000033',
          display: 'flex',
          flexDirection: 'column',
          gap: 18,
          alignItems: 'center',
        }}
      >
        <input
          name="identifier"
          type="text"
          placeholder="E-posta veya Telefon"
          value={form.identifier}
          onChange={handleChange}
          style={loginInputStyle}
        />
        <div style={{ position: 'relative', width: '109%', display: 'flex', alignItems: 'left' }}>
          <input
            name="password"
            type={showPassword ? 'text' : 'password'}
            placeholder="Şifre"
            value={form.password}
            onChange={handleChange}
            style={{ ...loginInputStyle, paddingRight: 40, marginBottom: 0 }}
          />
          <span
            onClick={() => setShowPassword((v) => !v)}
            style={{
              position: 'absolute',
              right: 16,
              top: '50%',
              transform: 'translateY(-50%)',
              cursor: 'pointer',
              color: '#888',
              fontSize: 20,
              userSelect: 'none',
              background: 'transparent'
            }}
            title={showPassword ? 'Şifreyi Gizle' : 'Şifreyi Göster'}
          >
            {showPassword ? '🙈' : '👁️'}
          </span>
        </div>
        <button
          type="submit"
          style={{
            background: '#40693E',
            color: '#fff',
            border: 'none',
            borderRadius: 10,
            padding: '16px 0',
            fontSize: 20,
            fontWeight: 700,
            cursor: 'pointer',
            marginTop: 10,
            letterSpacing: 1,
            width: '100%',
            boxShadow: '0 4px 16px #1d700133',
            transition: 'all 0.2s',
          }}
        >
          GİRİŞ YAP
        </button>
      </form>
      {submitError && (
        <div style={{
          color: '#d32f2f',
          background: '#ffebee',
          padding: '12px 24px',
          borderRadius: 8,
          marginTop: 20,
          textAlign: 'center',
          maxWidth: 400,
        }}>
          {submitError}
        </div>
      )}
    </div>
  );
}

const loginInputStyle: React.CSSProperties = {
  width: '100%',
  padding: '14px',
  borderRadius: 10,
  border: '1.5px solid #d1d5db',
  marginBottom: 8,
  fontSize: 17,
  background: '#f5f5ef',
  color: '#222',
  transition: 'all 0.2s',
  boxShadow: '0 1px 4px rgba(0,0,0,0.04)',
  outline: 'none',
};
