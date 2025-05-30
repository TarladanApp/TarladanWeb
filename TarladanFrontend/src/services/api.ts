import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:3000';

const api = axios.create({
  baseURL: API_URL,
});

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

export const loginFarmer = async (loginData) => {
  try {
    const response = await api.post('/farmer/login', loginData);
    return response.data;
  } catch (error) {
    throw error;
  }
}; 