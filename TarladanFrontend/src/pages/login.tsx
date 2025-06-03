import React, { useState, useEffect } from 'react';
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
  const [isMobile, setIsMobile] = useState(false);
  const navigate = useNavigate();

  // Mobile detection
  useEffect(() => {
    const checkMobile = () => {
      setIsMobile(window.innerWidth <= 768);
    };
    
    checkMobile();
    window.addEventListener('resize', checkMobile);
    
    return () => window.removeEventListener('resize', checkMobile);
  }, []);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setForm({ ...form, [name]: value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitError('');
    setIsLoading(true);
    try {
      console.log('=== Login Submit ===');
      console.log('Form data:', { farmer_mail: form.identifier, farmer_password: '***' });
      
      const response = await loginFarmer({
        farmer_mail: form.identifier,
        farmer_password: form.password,
      });
      
      console.log('Login response:', response);
      console.log('Response success:', response?.success);
      console.log('Response token mevcut:', !!response?.token);
      console.log('Response token uzunluğu:', response?.token?.length);
      
      if (response && response.success) {
        localStorage.setItem('token', response.token);
        localStorage.setItem('user', JSON.stringify(response.user));
        
        console.log('Token localStorage\'a kaydedildi');
        console.log('Saved token mevcut:', !!localStorage.getItem('token'));
        
        navigate('/dashboard');
      } else {
        console.error('Login başarısız:', response);
        setSubmitError(response.message || 'Giriş başarısız');
      }
    } catch (error: any) {
      console.error('Login error:', error);
      if (error.response && error.response.data && error.response.data.message) {
        setSubmitError(error.response.data.message);
      } else if (error.message) {
        setSubmitError(error.message);
      } else {
        setSubmitError('Giriş yapılırken bir hata oluştu');
      }
    } finally {
      setIsLoading(false);
    }
  };

  const containerStyle: React.CSSProperties = {
        width: '100vw',
        height: '100vh',
        background: '#698B69',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
    justifyContent: 'center',
    padding: isMobile ? '20px' : '40px',
    boxSizing: 'border-box',
    minHeight: '100vh',
    overflow: 'auto',
  };

  const logoStyle: React.CSSProperties = {
    width: isMobile ? 60 : 70,
    marginBottom: isMobile ? 18 : 18,
    marginTop: isMobile ? -60 : -140,
  };

  const titleStyle: React.CSSProperties = {
    color: '#fff',
    fontWeight: 800,
    fontSize: isMobile ? 26 : 38,
    marginBottom: isMobile ? 5 : 0,
    letterSpacing: 1,
    textAlign: 'center',
    textShadow: '0 2px 8px #0004',
    lineHeight: isMobile ? '1.1' : '1.1',
    padding: isMobile ? '0 10px' : 0,
  };

  const subtitleStyle: React.CSSProperties = {
    color: '#f8faf3',
    marginTop: isMobile ? 8 : 20,
    marginBottom: isMobile ? 6 : 10,
    fontWeight: 500,
    fontSize: isMobile ? 16 : 18,
    textAlign: 'center',
    padding: isMobile ? '0 20px' : 0,
    lineHeight: '1.3',
  };

  const registerLinkStyle: React.CSSProperties = {
    color: '#b6ffb6',
    marginTop: 0,
    marginBottom: isMobile ? 24 : 32,
    fontWeight: 500,
    fontSize: isMobile ? 16 : 18,
    textAlign: 'center',
    cursor: 'pointer',
    textDecoration: 'underline',
    transition: 'color 0.2s',
  };

  const formStyle: React.CSSProperties = {
    background: '#f8faf3',
    padding: isMobile ? 24 : 36,
    borderRadius: isMobile ? 20 : 24,
    width: isMobile ? '100%' : 'auto',
    minWidth: isMobile ? 'auto' : 340,
    maxWidth: isMobile ? '400px' : '400px',
    boxShadow: '0 6px 32px #00000033',
    display: 'flex',
    flexDirection: 'column',
    gap: isMobile ? 16 : 18,
    alignItems: 'center',
    margin: isMobile ? '0 auto' : '0',
  };

  const passwordContainerStyle: React.CSSProperties = {
    position: 'relative',
    width: '100%',
    display: 'flex',
    alignItems: 'center',
  };

  const eyeIconStyle: React.CSSProperties = {
    position: 'absolute',
    right: 16,
    top: '50%',
    transform: 'translateY(-50%)',
    cursor: 'pointer',
    color: '#888',
    fontSize: isMobile ? 18 : 20,
    userSelect: 'none',
    background: 'transparent',
    padding: '2px',
  };

  const buttonStyle: React.CSSProperties = {
    background: '#40693E',
    color: '#fff',
    border: 'none',
    borderRadius: 10,
    padding: isMobile ? '14px 0' : '16px 0',
    fontSize: isMobile ? 18 : 20,
    fontWeight: 700,
    cursor: isLoading ? 'not-allowed' : 'pointer',
    marginTop: 10,
    letterSpacing: 1,
    width: '100%',
    boxShadow: '0 4px 16px #1d700133',
    transition: 'all 0.2s',
    opacity: isLoading ? 0.7 : 1,
    minHeight: isMobile ? '50px' : '56px',
  };

  const errorStyle: React.CSSProperties = {
    color: '#dc2626',
    fontSize: isMobile ? 13 : 14,
    textAlign: 'center',
    width: '100%',
    padding: isMobile ? '0 10px' : 0,
    lineHeight: '1.4',
  };

  return (
    <div style={containerStyle}>
      <img
        src={require('../assets/brand-logo.png')}
        alt="Logo"
        style={logoStyle}
      />
      <h1 style={titleStyle}>
        TARLADANA HOŞ GELDİNİZ
      </h1>
      <p style={subtitleStyle}>
        Ürünlerinizi Yükleyip Çiftliğinizi Yönetin
      </p>
      <p
        onClick={() => window.location.href = '/register'}
        style={registerLinkStyle}
        title="Kayıt sayfasına git"
      >
        Kayıt Ol
      </p>
      <form onSubmit={handleSubmit} style={formStyle}>
        <input
          name="identifier"
          type="text"
          placeholder="E-posta veya Telefon"
          value={form.identifier}
          onChange={handleChange}
          style={{
            ...loginInputStyle,
            fontSize: isMobile ? 16 : 17,
            padding: isMobile ? '12px' : '14px',
          }}
        />
        <div style={passwordContainerStyle}>
          <input
            name="password"
            type={showPassword ? 'text' : 'password'}
            placeholder="Şifre"
            value={form.password}
            onChange={handleChange}
            style={{
              ...loginInputStyle,
              paddingRight: 40,
              marginBottom: 0,
              fontSize: isMobile ? 16 : 17,
              padding: isMobile ? '12px 40px 12px 12px' : '14px 40px 14px 14px',
            }}
          />
          <span
            onClick={() => setShowPassword((v) => !v)}
            style={eyeIconStyle}
            title={showPassword ? 'Şifreyi Gizle' : 'Şifreyi Göster'}
          >
            {showPassword ? '👁️' : '🙈'}
          </span>
        </div>
        {submitError && (
          <div style={errorStyle}>
            {submitError}
          </div>
        )}
        <button
          type="submit"
          disabled={isLoading}
          style={buttonStyle}
        >
          {isLoading ? 'GİRİŞ YAPILIYOR...' : 'GİRİŞ YAP'}
        </button>
      </form>
    </div>
  );
}

const loginInputStyle: React.CSSProperties = {
  width: '100%',
  borderRadius: 10,
  border: '1.5px solid #d1d5db',
  marginBottom: 8,
  background: '#f5f5ef',
  color: '#222',
  transition: 'all 0.2s',
  boxShadow: '0 1px 4px rgba(0,0,0,0.04)',
  outline: 'none',
  boxSizing: 'border-box',
};
