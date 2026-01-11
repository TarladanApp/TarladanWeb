import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:3001';

const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Token'ı header'a ekle
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  console.log('API Request interceptor - Token:', token ? 'Token mevcut' : 'Token yok');

  if (token) {
    try {
      // Token'ın geçerliliğini kontrol et
      const tokenParts = token.split('.');
      if (tokenParts.length === 3) {
        const payload = JSON.parse(atob(tokenParts[1]));
        const expirationTime = payload.exp * 1000;
        const currentTime = Date.now();

        if (currentTime >= expirationTime) {
          console.log('Token süresi dolmuş');
          clearAuthData();
          return Promise.reject('Token süresi dolmuş');
        }
      }

      // Token'ı header'a ekle
      config.headers['Authorization'] = `Bearer ${token}`;
      console.log('Token header\'a eklendi:', config.headers['Authorization'].substring(0, 50) + '...');
    } catch (error) {
      console.error('Token kontrolü hatası:', error);
      clearAuthData();
      return Promise.reject('Geçersiz token');
    }
  }

  console.log('API Request:', {
    method: config.method?.toUpperCase(),
    url: config.url,
    headers: {
      ...config.headers,
      Authorization: config.headers['Authorization'] ? 'Bearer [TOKEN]' : undefined
    }
  });
  return config;
});

// Response interceptor ekle
api.interceptors.response.use(
  (response) => {
    console.log('API Response:', {
      status: response.status,
      url: response.config.url,
      data: response.data
    });
    return response;
  },
  (error) => {
    console.log('API Error:', {
      status: error.response?.status,
      url: error.config?.url,
      data: error.response?.data,
      headers: error.config?.headers
    });

    if (error.response?.status === 401) {
      console.log('401 Unauthorized hatası - Login sayfasına yönlendiriliyor');
      clearAuthData();
    }
    return Promise.reject(error);
  }
);

// Auth verilerini temizle
const clearAuthData = () => {
  localStorage.removeItem('token');
  localStorage.removeItem('user');
  localStorage.removeItem('farmer');
  localStorage.removeItem('tokenExpiry');
  window.location.href = '/login';
};

export const registerFarmer = async (formData: FormData) => {
  try {
    const response = await api.post('/farmer', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    return response.data;
  } catch (error) {
    throw error;
  }
};

export const loginFarmer = async (loginData: any) => {
  try {
    console.log('Login isteği gönderiliyor:', { ...loginData, farmer_password: '***' });
    const response = await api.post('/farmer/login', {
      farmer_mail: loginData.identifier,
      farmer_password: loginData.password
    });
    console.log('Login yanıtı:', response.data);
    return response.data;
  } catch (error) {
    console.error('Login hatası:', error);
    throw error;
  }
};

// Order APIs
export const getFarmerOrders = async () => {
  try {
    console.log('getFarmerOrders - API çağrısı başlıyor...');
    const response = await api.get('/order/farmer');
    console.log('getFarmerOrders - API response:', response.data);
    return response.data;
  } catch (error: any) {
    console.error('getFarmerOrders - API hatası:', error);
    throw error;
  }
};

export const updateOrderStatus = async (orderProductId: string, status: string) => {
  try {
    console.log('updateOrderStatus - API çağrısı:', { orderProductId, status });
    const response = await api.patch(`/order/${orderProductId}/status`, { status });
    console.log('updateOrderStatus - API response:', response.data);
    return response.data;
  } catch (error: any) {
    console.error('updateOrderStatus - API hatası:', error);
    throw error;
  }
};

// Product APIs
export const getProducts = async () => {
  try {
    console.log('getProducts - API çağrısı başlıyor...');
    const response = await api.get('/product');
    console.log('getProducts - API response:', response.data);
    return response.data;
  } catch (error: any) {
    console.error('getProducts - API hatası:', error);
    throw error;
  }
};

export const getFarmerProfile = async () => {
  try {
    console.log('getFarmerProfile - API çağrısı başlıyor...');
    const response = await api.get('/farmer/profile');
    console.log('getFarmerProfile - API response:', response.data);
    return response.data;
  } catch (error: any) {
    console.error('getFarmerProfile - API hatası:', error);
    throw error;
  }
};

export const getStoreInfo = async () => {
  try {
    console.log('getStoreInfo - API çağrısı başlıyor...');
    const response = await api.get('/farmer/store/info');
    console.log('getStoreInfo - API response:', response.data);
    return response.data;
  } catch (error: any) {
    console.error('getStoreInfo - API hatası:', error);
    throw error;
  }
};

// Mağaza durumu API'leri
export const getStoreActivity = async () => {
  try {
    console.log('getStoreActivity - API çağrısı başlıyor...');
    const response = await api.get('/farmer/store/activity');
    console.log('getStoreActivity - API response:', response.data);
    return response.data;
  } catch (error: any) {
    console.error('getStoreActivity - API hatası:', error);
    throw error;
  }
};

export const updateStoreActivity = async (storeActivity: 'active' | 'nonactive') => {
  try {
    console.log('updateStoreActivity - API çağrısı:', { storeActivity });
    const response = await api.put('/farmer/store/activity', { storeActivity });
    console.log('updateStoreActivity - API response:', response.data);
    return response.data;
  } catch (error: any) {
    console.error('updateStoreActivity - API hatası:', error);
    throw error;
  }
};

export default api; 