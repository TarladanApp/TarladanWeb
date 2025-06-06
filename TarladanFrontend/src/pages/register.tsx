import React, { useState } from 'react';
import { registerFarmer } from '../services/api';

const initialState = {
  firstName: '',
  lastName: '',
  phone: '',
  email: '',
  password: '',
  age: '',
  address: '',
  city: '',
  district: '',
  neighborhood: '',
  farmName: '',
  tcNo: '',
  farmer_certificates: null as File | null,
  birthDate: '',
  imgurl: null as string | null,
};

export default function Register() {
  const [form, setForm] = useState(initialState);
  const [errors, setErrors] = useState<{ [key: string]: string }>({});
  const [isLoading, setIsLoading] = useState(false);
  const [submitError, setSubmitError] = useState('');

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value, files } = e.target;
    if (name === 'farmer_certificates') {
      setForm({ ...form, [name]: files ? files[0] : null });
    } else {
      setForm({ ...form, [name]: value });
    }
  };

  const validate = () => {
    const newErrors: { [key: string]: string } = {};
    if (!form.firstName) newErrors.firstName = 'İsim zorunlu';
    if (!form.lastName) newErrors.lastName = 'Soyisim zorunlu';
    if (!form.phone) newErrors.phone = 'Telefon numarası zorunlu';
    if (!form.email) newErrors.email = 'E-posta adresi zorunlu';
    if (!form.password) newErrors.password = 'Şifre zorunlu';
    if (!form.birthDate) newErrors.birthDate = 'Doğum tarihi zorunlu';
    if (!form.address) newErrors.address = 'Adres zorunlu';
    if (!form.city) newErrors.city = 'Şehir zorunlu';
    if (!form.district) newErrors.district = 'İlçe zorunlu';
    if (!form.neighborhood) newErrors.neighborhood = 'Mahalle zorunlu';
    if (!form.farmName) newErrors.farmName = 'Çiftlik ismi zorunlu';
    if (!form.tcNo) newErrors.tcNo = 'TC Kimlik numarası zorunlu';
    return newErrors;
  };

  // Backend alan adlarını frontend alan adlarına eşleyecek bir fonksiyon
  const backendToFrontendField: { [key: string]: string } = {
    farmer_password: 'password',
    farmer_name: 'firstName',
    farmer_last_name: 'lastName',
    farmer_age: 'birthDate', // Yaş doğum tarihinden hesaplanıyor
    farmer_address: 'address',
    farmer_city: 'city',
    farmer_town: 'district',
    farmer_neighbourhood: 'neighborhood',
    farmer_phone_number: 'phone',
    farmer_mail: 'email',
    farmer_activity_status: '', // Formda yok, validasyon hatası gelirse genel hata olarak gösterilebilir
    farm_name: 'farmName',
    farmer_tc_no: 'tcNo',
    imgurl: '',
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitError('');
    const validationErrors = validate();
    setErrors(validationErrors);

    if (Object.keys(validationErrors).length === 0) {
      try {
        setIsLoading(true);
        // Doğum tarihinden yaş hesaplama
        const birthDate = new Date(form.birthDate);
        const today = new Date();
        const age = today.getFullYear() - birthDate.getFullYear();
        const monthDiff = today.getMonth() - birthDate.getMonth();
        const calculatedAge = monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate()) 
          ? age - 1 
          : age;

        // FormData objesi oluştur
        const formData = new FormData();

        // Form verilerini FormData'ya ekle
        formData.append('farmer_password', form.password);
        formData.append('farmer_name', form.firstName);
        formData.append('farmer_last_name', form.lastName);
        formData.append('farmer_age', calculatedAge.toString());
        formData.append('farmer_address', form.address);
        formData.append('farmer_city', form.city);
        formData.append('farmer_town', form.district);
        formData.append('farmer_neighbourhood', form.neighborhood);
        formData.append('farmer_phone_number', form.phone);
        formData.append('farmer_mail', form.email);
        formData.append('farmer_activity_status', 'NonActive');
        formData.append('farm_name', form.farmName);
        formData.append('farmer_tc_no', form.tcNo);

        // Sertifika dosyasını ekle (varsa)
        if (form.farmer_certificates) {
          formData.append('farmer_certificates', form.farmer_certificates);
        }

        const response = await registerFarmer(formData);

        if (response.success) {
          alert('Kayıt başarılı! Giriş sayfasına yönlendiriliyorsunuz.');
          window.location.href = '/login';
        }
      } catch (error: any) {
        if (
          error.response &&
          error.response.data &&
          Array.isArray(error.response.data.message)
        ) {
          const backendErrors: { [key: string]: string } = {};
          const unmappedErrors: string[] = [];
          
          error.response.data.message.forEach((msg: string) => {
            const match = msg.match(/^property (\w+) (.+)$/);
            if (match) {
              const backendField = match[1];
              const message = match[2];
              const frontendField = backendToFrontendField[backendField];
              
              if (frontendField) {
                // Eğer bu alan için zaten bir hata varsa, virgülle ayırarak ekle
                if (backendErrors[frontendField]) {
                  backendErrors[frontendField] += `, ${message}`;
                } else {
                  backendErrors[frontendField] = message;
                }
              } else {
                // Mapping bulunamayan hataları topla
                unmappedErrors.push(msg);
              }
            } else {
              // Property formatında olmayan hataları topla
              unmappedErrors.push(msg);
            }
          });

          setErrors(backendErrors);
          // Sadece mapping bulunamayan hataları üstte göster
          setSubmitError(unmappedErrors.length > 0 ? unmappedErrors.join(', ') : '');
        } else if (
          error.response &&
          error.response.data &&
          error.response.data.message
        ) {
          setSubmitError(error.response.data.message);
        } else if (error.message) {
          setSubmitError(error.message);
        } else {
          setSubmitError('Beklenmedik bir hata oluştu.');
        }
      } finally {
        setIsLoading(false);
      }
    }
  };

  return (
    <div style={{
      minHeight: '120vh',
      background: '#698B69',
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      justifyContent: 'center',
      fontFamily: 'Inter, Arial, sans-serif',
      marginRight: 10,
      width: '100%',
    }}>
      <img src={require('../assets/brand-logo.png')} alt="Logo" style={{ width: 64, marginBottom: 18, marginTop: 0 }} />
      <h1 style={{ color: '#f8faf3', fontWeight: 800, fontSize: 38, marginBottom: 0, letterSpacing: 1, textAlign: 'center', textShadow: '0 2px 8px #0004' }}>ÇİFTÇİ KAYIT FORMU</h1>
      <p
        onClick={() => window.location.href = '/login'}
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
        title="Giriş sayfasına git"
      >
        Giriş Sayfası
      </p>
      {submitError && (
        <div style={{
          color: '#d32f2f',
          background: '#ffebee',
          padding: '12px 24px',
          borderRadius: 8,
          marginBottom: 20,
          textAlign: 'center',
          maxWidth: 900,
          width: '85vw',
        }}>
          {submitError}
        </div>
      )}
      <form
        onSubmit={handleSubmit}
        encType="multipart/form-data"
        style={{
          alignItems: 'center',
          background: '#f8faf3',
          padding: 40,
          borderRadius: 18,
          width: '85vw',
          maxWidth: 900,
          minWidth: 320,
          boxShadow: '0 6px 32px #00000044',
          display: 'grid',
          gridTemplateColumns: '1fr 1fr',
          gap: 20,
          margin: '0 auto',
        }}
        className="responsive-register-form"
        onMouseEnter={(e) => {
          e.currentTarget.style.boxShadow = '0 6px 30px #00000033';
        }}
        onMouseLeave={(e) => {
          e.currentTarget.style.boxShadow = '0 6px 32px #00000044';
        }}
      >
        <div>
          <label>İsim*</label>
          <input name="firstName" value={form.firstName} onChange={handleChange} style={inputStyle} />
          {errors.firstName && <span style={errorStyle}>{errors.firstName}</span>}
        </div>
        <div>
          <label>Soyisim*</label>
          <input name="lastName" value={form.lastName} onChange={handleChange} style={inputStyle} />
          {errors.lastName && <span style={errorStyle}>{errors.lastName}</span>}
        </div>
        <div>
          <label>Telefon Numarası*</label>
          <input name="phone" value={form.phone} onChange={handleChange} style={inputStyle} />
          {errors.phone && <span style={errorStyle}>{errors.phone}</span>}
        </div>
        <div>
          <label>Eposta Adresi*</label>
          <input name="email" type="email" value={form.email} onChange={handleChange} style={inputStyle} />
          {errors.email && <span style={errorStyle}>{errors.email}</span>}
        </div>
        <div>
          <label>Şifre*</label>
          <input name="password" type="password" value={form.password} onChange={handleChange} style={inputStyle} />
          {errors.password && <span style={errorStyle}>{errors.password}</span>}
        </div>
        <div>
          <label>Doğum Tarihi*</label>
          <input name="birthDate" type="date" value={form.birthDate || ''} onChange={handleChange} style={inputStyle} />
          {errors.birthDate && <span style={errorStyle}>{errors.birthDate}</span>}
        </div>
        <div>
          <label>Adres*</label>
          <input name="address" value={form.address} onChange={handleChange} style={inputStyle} />
          {errors.address && <span style={errorStyle}>{errors.address}</span>}
        </div>
        <div>
          <label>Şehir*</label>
          <input name="city" value={form.city} onChange={handleChange} style={inputStyle} />
          {errors.city && <span style={errorStyle}>{errors.city}</span>}
        </div>
        <div>
          <label>İlçe*</label>
          <input name="district" value={form.district} onChange={handleChange} style={inputStyle} />
          {errors.district && <span style={errorStyle}>{errors.district}</span>}
        </div>
        <div>
          <label>Mahalle*</label>
          <input name="neighborhood" value={form.neighborhood} onChange={handleChange} style={inputStyle} />
          {errors.neighborhood && <span style={errorStyle}>{errors.neighborhood}</span>}
        </div>
        <div>
          <label>Çiftlik İsmi*</label>
          <input name="farmName" value={form.farmName} onChange={handleChange} style={inputStyle} />
          {errors.farmName && <span style={errorStyle}>{errors.farmName}</span>}
        </div>
        <div>
          <label>Tc Kimlik Numarası*</label>
          <input name="tcNo" value={form.tcNo} onChange={handleChange} style={inputStyle} />
          {errors.tcNo && <span style={errorStyle}>{errors.tcNo}</span>}
        </div>
        <div style={{ gridColumn: '1/3' }}>
          <label>Sertifikalar (opsiyonel)</label>
          <input name="farmer_certificates" type="file" onChange={handleChange} style={inputStyle} />
        </div>    
        <button
          type="submit"
          disabled={isLoading}
          style={{
            gridColumn: '1/3',
            background: isLoading ? '#ccc' : 'linear-gradient(90deg, #1D7001 0%, #269900 100%)',
            color: '#fff',
            border: 'none',
            marginRight: 10,
            borderRadius: 10,
            padding: '16px 0',
            fontSize: 20,
            fontWeight: 700,
            cursor: isLoading ? 'not-allowed' : 'pointer',
            marginTop: 10,
            letterSpacing: 1,
            boxShadow: '0 4px 16px #1d700133',
            transition: 'all 0.2s',
          }}
        >
          {isLoading ? 'GÖNDERİLİYOR...' : 'FORMU GÖNDER'}
        </button> 
      </form>
    </div>
  );
}

const inputStyle: React.CSSProperties = {
  width: '95%',
  padding: '12px',
  borderRadius: 10,
  border: '1.5px solid #d1d5db',
  marginTop: 6,
  flex: 2,
  marginRight: 1,
  marginBottom: 4,
  fontSize: 17,
  background: '#f5f5ef',
  color: '#222',
  transition: 'all 0.2s',
  boxShadow: '0 1px 4px rgba(0,0,0,0.04)',
  outline: 'none',
};

const errorStyle: React.CSSProperties = {
  color: '#d32f2f',
  fontSize: 12,
};

// Mobil uyumlu form stili - kullanılmıyor, inline style kullanılıyor
// const formStyle = {
//   alignItems: 'center',
//   background: '#f8faf3',
//   padding: 40,
//   borderRadius: 18,
//   width: '85vw',
//   maxWidth: 900,
//   minWidth: 320,
//   boxShadow: '0 6px 32px #00000044',
//   display: 'grid',
//   gridTemplateColumns: '1fr 1fr',
//   gap: 24,
//   transition: 'all 0.3s ease',
// };

// Media query ile mobilde tek kolona düşür
const styleSheet = document.createElement('style');
styleSheet.innerHTML = `
  @media (max-width: 700px) {
    .responsive-register-form {
      min-width: 50vw !important;
      max-width: 108vw !important;
      padding: 16px !important;
      margin-left: 10px !important;
      grid-template-columns: 1fr !important;
      gap: 12px !important;
      textAlign: 'center' !important;
    }
    .responsive-register-form > div {
      grid-column: 1 / 2 !important;
      width: 100% !important;
      marginLeft: 10 !important;
    }
    .responsive-register-form label,
    .responsive-register-form input,
    .responsive-register-form span {
      width: 90% !important;
      textAlign: 'center' !important;
      display: block !important;
      marginLeft: 10 !important;
      
    }
  }
`;
if (typeof window !== 'undefined' && !document.getElementById('register-form-style')) {
  styleSheet.id = 'register-form-style';
  document.head.appendChild(styleSheet);
}