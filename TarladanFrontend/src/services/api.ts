import axios from 'axios';

const API_URL = 'http://localhost:3001';

const api = axios.create({
  baseURL: API_URL,
});

// Token'ı header'a ekle
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  console.log('API Request interceptor - Token:', token ? 'Token mevcut' : 'Token yok');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  console.log('API Request:', config.method?.toUpperCase(), config.url);
  return config;
});

// Response interceptor ekle
api.interceptors.response.use(
  (response) => {
    console.log('API Response:', response.status, response.config.url);
    return response;
  },
  (error) => {
    console.log('API Error:', error.response?.status, error.response?.data);
    return Promise.reject(error);
  }
);

export const registerFarmer = async (formData: FormData) => {
  try {
    const response = await api.post('/farmer', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });
    return response.data;
  } catch (error: any) {
    throw error;
  }
};

export const loginFarmer = async (loginData: any) => {
  try {
    const response = await api.post('/farmer/login', loginData);
    return response.data;
  } catch (error) {
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
    console.error('getFarmerOrders - Error response:', error.response?.data);
    console.error('getFarmerOrders - Error status:', error.response?.status);
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