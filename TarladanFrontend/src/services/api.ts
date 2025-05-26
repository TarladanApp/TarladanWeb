import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:3000';

const api = axios.create({
  baseURL: API_URL,
  headers: {
    // Content-Type FormData için otomatik ayarlanacak
  },
});

export const registerFarmer = async (farmerData: any) => {
  try {
    let headers = {};
    let dataToSend = farmerData;

    if (farmerData instanceof FormData) {
      // FormData gönderiliyorsa Content-Type'ı belirtmeye gerek yok, axios halleder
      headers = {};
    } else {
      // Diğer veri türleri (örneğin JSON) gönderiliyorsa Content-Type'ı ayarla
      headers = {
        'Content-Type': 'application/json',
      };
    }

    const response = await api.post('/farmer', dataToSend, { headers });

    return response.data;
  } catch (error: any) {
    throw new Error(error.response?.data?.message || 'Kayıt işlemi başarısız oldu');
  }
};

export const loginFarmer = async (loginData: any) => {
  try {
    const response = await api.post('/farmer/login', loginData);
    return response.data;
  } catch (error: any) {
    throw new Error(error.response?.data?.message || 'Giriş işlemi başarısız oldu');
  }
}; 