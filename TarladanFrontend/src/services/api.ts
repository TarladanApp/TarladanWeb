import axios from 'axios';

const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:3000';

const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

export const registerFarmer = async (farmerData: any) => {
  try {
    const response = await api.post('/farmer', {
      farmer_password: farmerData.password,
      farmer_name: farmerData.firstName,
      farmer_last_name: farmerData.lastName,
      farmer_age: farmerData.age,
      farmer_address: farmerData.address,
      farmer_city: farmerData.city,
      farmer_town: farmerData.district,
      famer_neighbourhood: farmerData.neighborhood,
      farmer_phone_number: farmerData.phone,
      farmer_mail: farmerData.email,
      farmer_certificates: farmerData.farmer_certificates ? farmerData.farmer_certificates.name : '',
      farmer_activity_status: 'NonActive',
      farm_name: farmerData.farmName,
      farmer_tc_no: farmerData.tcNo,
    });
    return response.data;
  } catch (error: any) {
    throw new Error(error.response?.data?.message || 'Kayıt işlemi başarısız oldu');
  }
}; 