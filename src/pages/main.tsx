import React from 'react';
import { useNavigate } from 'react-router-dom';

export default function MainPage() {
  const navigate = useNavigate();

  return (
    <div
      style={{
        height: '100vh',
        background: 'linear-gradient(135deg, #698B69)',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
      }}
    >
      <img
        src={require('../assets/brand-logo.png')}
        alt="Logo"
        style={{ width: 100, marginBottom: 24 }}
      />
      <h1 style={{ color: '#fff', fontWeight: 700, fontSize: 40, marginBottom: 8 }}>
        TarladanWeb
      </h1>
      <p style={{ color: '#b6ffb6', fontSize: 20, marginBottom: 32 }}>
        Çiftçi Platformuna Hoş Geldiniz
      </p>
      <button
        onClick={() => navigate('/register')}
        style={{
          background: '#1D7021',
          color: '#fff',
          border: 'none',
          borderRadius: 8,
          padding: '16px 40px',
          fontSize: 22,
          fontWeight: 600,
          cursor: 'pointer',
          boxShadow: '0 4px 16px #00000022',
          transition: 'background 0.2s',
        }}
      >
        Kayıt Ol
      </button>
    </div>
  );
}