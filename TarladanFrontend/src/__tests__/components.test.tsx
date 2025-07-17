import React, { useState } from 'react';
import { render, screen, fireEvent } from '@testing-library/react';

// Basit Login Form Component
const LoginForm = ({ onSubmit, loading = false }: { 
  onSubmit: (data: { email: string; password: string }) => void, 
  loading?: boolean 
}) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [errors, setErrors] = useState<{ email?: string; password?: string }>({});

  const validateForm = () => {
    const newErrors: { email?: string; password?: string } = {};
    
    if (!email) newErrors.email = 'E-posta zorunludur';
    else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      newErrors.email = 'Geçerli bir e-posta girin';
    }
    
    if (!password) newErrors.password = 'Şifre zorunludur';
    else if (password.length < 6) newErrors.password = 'Şifre en az 6 karakter olmalı';
    
    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (validateForm()) {
      onSubmit({ email, password });
    }
  };

  return (
    <form onSubmit={handleSubmit} data-testid="login-form">
      <div>
        <label htmlFor="email">E-posta</label>
        <input
          id="email"
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="E-posta adresinizi girin"
          data-testid="email-input"
        />
        {errors.email && <span data-testid="email-error">{errors.email}</span>}
      </div>
      
      <div>
        <label htmlFor="password">Şifre</label>
        <input
          id="password"
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="Şifrenizi girin"
          data-testid="password-input"
        />
        {errors.password && <span data-testid="password-error">{errors.password}</span>}
      </div>
      
      <button type="submit" disabled={loading} data-testid="submit-button">
        {loading ? 'Giriş yapılıyor...' : 'Giriş Yap'}
      </button>
    </form>
  );
};

// Basit Register Form Component
const RegisterForm = ({ onSubmit }: { 
  onSubmit: (data: { name: string; email: string; phone: string }) => void 
}) => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    phone: ''
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSubmit(formData);
  };

  return (
    <form onSubmit={handleSubmit} data-testid="register-form">
      <input
        name="name"
        type="text"
        value={formData.name}
        onChange={handleChange}
        placeholder="Adınız Soyadınız"
        data-testid="name-input"
      />
      <input
        name="email"
        type="email"
        value={formData.email}
        onChange={handleChange}
        placeholder="E-posta"
        data-testid="email-input"
      />
      <input
        name="phone"
        type="tel"
        value={formData.phone}
        onChange={handleChange}
        placeholder="Telefon"
        data-testid="phone-input"
      />
      <button type="submit" data-testid="register-button">
        Kayıt Ol
      </button>
    </form>
  );
};

describe('Form Component Testleri', () => {
  describe('LoginForm', () => {
    const mockOnSubmit = jest.fn();

    beforeEach(() => {
      mockOnSubmit.mockClear();
    });

    test('form elementleri doğru render edilir', () => {
      render(<LoginForm onSubmit={mockOnSubmit} />);
      
      expect(screen.getByTestId('login-form')).toBeInTheDocument();
      expect(screen.getByTestId('email-input')).toBeInTheDocument();
      expect(screen.getByTestId('password-input')).toBeInTheDocument();
      expect(screen.getByTestId('submit-button')).toBeInTheDocument();
    });

    test('kullanıcı email ve şifre girebilir', () => {
      render(<LoginForm onSubmit={mockOnSubmit} />);
      
      const emailInput = screen.getByTestId('email-input') as HTMLInputElement;
      const passwordInput = screen.getByTestId('password-input') as HTMLInputElement;
      
      fireEvent.change(emailInput, { target: { value: 'test@example.com' } });
      fireEvent.change(passwordInput, { target: { value: 'password123' } });
      
      expect(emailInput.value).toBe('test@example.com');
      expect(passwordInput.value).toBe('password123');
    });

    test('geçerli form gönderildiğinde onSubmit çağrılır', () => {
      render(<LoginForm onSubmit={mockOnSubmit} />);
      
      const emailInput = screen.getByTestId('email-input');
      const passwordInput = screen.getByTestId('password-input');
      const submitButton = screen.getByTestId('submit-button');
      
      fireEvent.change(emailInput, { target: { value: 'test@example.com' } });
      fireEvent.change(passwordInput, { target: { value: 'password123' } });
      fireEvent.click(submitButton);
      
      expect(mockOnSubmit).toHaveBeenCalledWith({
        email: 'test@example.com',
        password: 'password123'
      });
    });

    test('boş email ile hata mesajı görüntülenir', () => {
      render(<LoginForm onSubmit={mockOnSubmit} />);
      
      const passwordInput = screen.getByTestId('password-input');
      const submitButton = screen.getByTestId('submit-button');
      
      fireEvent.change(passwordInput, { target: { value: 'password123' } });
      fireEvent.click(submitButton);
      
      expect(screen.getByTestId('email-error')).toHaveTextContent('E-posta zorunludur');
      expect(mockOnSubmit).not.toHaveBeenCalled();
    });

    test('geçersiz email formatı ile hata mesajı görüntülenir', () => {
      render(<LoginForm onSubmit={mockOnSubmit} />);
      
      const emailInput = screen.getByTestId('email-input');
      const passwordInput = screen.getByTestId('password-input');
      const submitButton = screen.getByTestId('submit-button');
      
      fireEvent.change(emailInput, { target: { value: 'invalid-email' } });
      fireEvent.change(passwordInput, { target: { value: 'password123' } });
      fireEvent.click(submitButton);
      
      expect(screen.getByTestId('email-error')).toHaveTextContent('Geçerli bir e-posta girin');
    });

    test('kısa şifre ile hata mesajı görüntülenir', () => {
      render(<LoginForm onSubmit={mockOnSubmit} />);
      
      const emailInput = screen.getByTestId('email-input');
      const passwordInput = screen.getByTestId('password-input');
      const submitButton = screen.getByTestId('submit-button');
      
      fireEvent.change(emailInput, { target: { value: 'test@example.com' } });
      fireEvent.change(passwordInput, { target: { value: '123' } });
      fireEvent.click(submitButton);
      
      expect(screen.getByTestId('password-error')).toHaveTextContent('Şifre en az 6 karakter olmalı');
    });

    test('loading durumunda buton disable olur', () => {
      render(<LoginForm onSubmit={mockOnSubmit} loading={true} />);
      
      const submitButton = screen.getByTestId('submit-button');
      expect(submitButton).toBeDisabled();
      expect(submitButton).toHaveTextContent('Giriş yapılıyor...');
    });
  });

  describe('RegisterForm', () => {
    const mockOnSubmit = jest.fn();

    beforeEach(() => {
      mockOnSubmit.mockClear();
    });

    test('kayıt formu doğru render edilir', () => {
      render(<RegisterForm onSubmit={mockOnSubmit} />);
      
      expect(screen.getByTestId('register-form')).toBeInTheDocument();
      expect(screen.getByTestId('name-input')).toBeInTheDocument();
      expect(screen.getByTestId('email-input')).toBeInTheDocument();
      expect(screen.getByTestId('phone-input')).toBeInTheDocument();
      expect(screen.getByTestId('register-button')).toBeInTheDocument();
    });

    test('form verileri girilip gönderilebilir', () => {
      render(<RegisterForm onSubmit={mockOnSubmit} />);
      
      const nameInput = screen.getByTestId('name-input');
      const emailInput = screen.getByTestId('email-input');
      const phoneInput = screen.getByTestId('phone-input');
      const submitButton = screen.getByTestId('register-button');
      
      fireEvent.change(nameInput, { target: { value: 'Test Çiftçi' } });
      fireEvent.change(emailInput, { target: { value: 'test@example.com' } });
      fireEvent.change(phoneInput, { target: { value: '05555555555' } });
      fireEvent.click(submitButton);
      
      expect(mockOnSubmit).toHaveBeenCalledWith({
        name: 'Test Çiftçi',
        email: 'test@example.com',
        phone: '05555555555'
      });
    });
  });
}); 