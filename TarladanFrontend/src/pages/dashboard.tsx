import React, { useState, useCallback, useEffect } from 'react';
import Cropper from 'react-easy-crop';
import { useNavigate } from 'react-router-dom';
import { supabase } from '../services/supabase';

const categories = [
  { value: '', label: 'Select' },
  { value: 'vegetable', label: 'Vegetable' },
  { value: 'fruit', label: 'Fruit' },
  { value: 'grain', label: 'Grain' },
];

const initialProducts: any[] = []; // Başlangıçta boş dizi

// Base64'ü File objesine çeviren yardımcı fonksiyon
function base64ToFile(base64String: string, fileName: string): File {
  try {
    console.log('=== Base64 to File Debug ===');
    console.log('Base64 string length:', base64String.length);
    console.log('Base64 string start:', base64String.substring(0, 50));
    
    // Data URL formatını kontrol et (data:image/jpeg;base64,...)
    const arr = base64String.split(',');
    if (arr.length !== 2) {
      throw new Error('Invalid base64 format');
    }
    
    const mime = arr[0].match(/:(.*?);/)?.[1] || 'image/jpeg';
    const bstr = atob(arr[1]);
    let n = bstr.length;
    const u8arr = new Uint8Array(n);
    
    console.log('MIME type:', mime);
    console.log('Binary string length:', n);
    
    while (n--) {
      u8arr[n] = bstr.charCodeAt(n);
    }
    
    const file = new File([u8arr], fileName, { type: mime });
    console.log('Created file:', {
      name: file.name,
      size: file.size,
      type: file.type
    });
    
    return file;
  } catch (error) {
    console.error('Base64 to File error:', error);
    throw error;
  }
}

function getCroppedImg(imageSrc: string, crop: any, zoom: number, aspect: number, size = 82) {
  return new Promise<string>((resolve, reject) => {
    const image = new window.Image();
    image.crossOrigin = 'anonymous';
    
    image.onload = () => {
      console.log('=== Image Load Debug ===');
      console.log('Original image dimensions:', {
        width: image.width,
        height: image.height,
        naturalWidth: image.naturalWidth,
        naturalHeight: image.naturalHeight
      });
      console.log('Crop parameters:', crop);
      console.log('Zoom:', zoom);
      
      const canvas = document.createElement('canvas');
      const ctx = canvas.getContext('2d');
      
      if (!ctx) {
        reject(new Error('Canvas context not available'));
        return;
      }
      
      // Canvas boyutunu ayarla
      canvas.width = size;
      canvas.height = size;
      
      // Eğer crop bilgisi yoksa, merkezi kare al
      if (!crop || typeof crop.x === 'undefined' || typeof crop.width === 'undefined') {
        console.log('No valid crop data, using center crop');
        const minDimension = Math.min(image.naturalWidth, image.naturalHeight);
        const startX = (image.naturalWidth - minDimension) / 2;
        const startY = (image.naturalHeight - minDimension) / 2;
        
        console.log('Center crop:', { startX, startY, minDimension });
        
        // Resmi çiz - merkezi kare
        ctx.drawImage(
          image,
          startX, startY, minDimension, minDimension,
          0, 0, size, size
        );
      } else {
        // Crop koordinatlarını kullan
        console.log('Using crop coordinates:', crop);
        
        // react-easy-crop'tan gelen koordinatları kullan
        const sx = crop.x;
        const sy = crop.y;
        const sw = crop.width;
        const sh = crop.height;
        
        console.log('Final crop coordinates:', { sx, sy, sw, sh });
        
        // Resmi çiz
        ctx.drawImage(
          image,
          sx, sy, sw, sh,
          0, 0, size, size
        );
      }
      
      // Base64'e dönüştür
      try {
        const base64 = canvas.toDataURL('image/jpeg', 0.9);
        console.log('=== Canvas to Base64 Debug ===');
        console.log('Canvas size:', canvas.width, 'x', canvas.height);
        console.log('Base64 length:', base64.length);
        console.log('Base64 start:', base64.substring(0, 100));
        
        if (base64.length < 100) {
          reject(new Error('Generated base64 is too short'));
          return;
        }
        
        resolve(base64);
      } catch (error) {
        console.error('Canvas to base64 error:', error);
        reject(error);
      }
    };
    
    image.onerror = (error) => {
      console.error('Image load error:', error);
      reject(new Error('Failed to load image'));
    };
    
    image.src = imageSrc;
  });
}

export default function Dashboard() {
  const navigate = useNavigate();

  const [product, setProduct] = useState({
    name: '',
    category: '',
    description: '',
    price: '',
    stock: '',
    image: '' as string | File, // Type'ı güncelle
    imagePreview: '',
  });
  const [products, setProducts] = useState(initialProducts);
  const [farmInfo, setFarmInfo] = useState<{ 
    farmer_biografi: string; 
    farm_name: string;
    images: any[];
    certificates: any[];
    newImages: File[];
    newCertificates: File[];
  }>({
    farmer_biografi: '',
    farm_name: '',
    images: [],
    certificates: [],
    newImages: [],
    newCertificates: []
  });
  const [tab, setTab] = useState<'product' | 'farm'>('product');
  const [crop, setCrop] = useState({ x: 0, y: 0 });
  const [zoom, setZoom] = useState(1);
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const [croppedAreaPixels, setCroppedAreaPixels] = useState<any>(null);
  const [editMode, setEditMode] = useState(false);
  const [editIndex, setEditIndex] = useState<number | null>(null);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [tempImageSrc, setTempImageSrc] = useState('');
  const [isCropping, setIsCropping] = useState(false);

  const onCropComplete = useCallback((croppedArea: any, croppedAreaPixels: any) => {
    console.log('=== Crop Complete Debug ===');
    console.log('croppedArea:', croppedArea);
    console.log('croppedAreaPixels:', croppedAreaPixels);
    setCroppedAreaPixels(croppedAreaPixels);
    // Crop state'ini de güncelle
    setCrop({ x: croppedAreaPixels.x, y: croppedAreaPixels.y });
  }, []);

  // Ürünleri backend'den çekme fonksiyonu
  const fetchProducts = useCallback(async () => {
    try {
      const token = localStorage.getItem('token');
      if (!token) {
        console.error('Token bulunamadı');
        navigate('/login');
        return;
      }

      const API_URL = 'http://localhost:3001';
      const response = await fetch(`${API_URL}/product`, {
        method: 'GET',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        if (response.status === 401) {
          localStorage.removeItem('token');
          localStorage.removeItem('user');
          navigate('/login');
          return;
        }
        const errorData = await response.json();
        throw new Error(errorData.message || 'Ürünler getirilirken bir hata oluştu.');
      }

      const productsData = await response.json();
      setProducts(productsData.map((p: any) => ({
        name: p.product_name,
        category: categories.find(c => c.value === p.product_katalog_name)?.label || p.product_katalog_name,
        price: p.farmer_price,
        stock: p.stock_quantity,
        id: p.id,
        image_url: p.image_url,
      })));
    } catch (error: any) {
      console.error('Ürünler getirilirken hata:', error);
    }
  }, [navigate]);

  // Mağaza bilgilerini backend'den çekme fonksiyonu
  const fetchStoreInfo = useCallback(async () => {
    try {
    const token = localStorage.getItem('token');
      if (!token) {
        console.error('Token bulunamadı');
        return;
      }

      const API_URL = 'http://localhost:3001';
      const response = await fetch(`${API_URL}/farmer/store/info`, {
        method: 'GET',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (response.ok) {
        const storeData = await response.json();
        setFarmInfo(prev => ({
          ...prev,
          farmer_biografi: storeData.farmer_biografi || '',
          farm_name: storeData.farm_name || '',
          images: storeData.images || [],
          certificates: storeData.certificates || []
        }));
      }
    } catch (error: any) {
      console.error('Mağaza bilgileri getirilirken hata:', error);
    }
  }, []);

  // Ürün ekleme
  const handleAddProduct = async (e: React.FormEvent) => {
    e.preventDefault();

    console.log('=== Frontend Product Add Debug ===');
    console.log('Product data:', product);
    console.log('Product image type:', typeof product.image);
    console.log('Product image instanceof File:', product.image instanceof File);
    if (product.image instanceof File) {
      console.log('File details:', {
        name: product.image.name,
        size: product.image.size,
        type: product.image.type,
        lastModified: product.image.lastModified
      });
      
      // File içeriğini okuyup kontrol et
      const reader = new FileReader();
      reader.onload = (e) => {
        console.log('File content length (ArrayBuffer):', e.target?.result ? (e.target.result as ArrayBuffer).byteLength : 0);
      };
      reader.readAsArrayBuffer(product.image);
      }

    try {
      const token = localStorage.getItem('token');
      if (!token) {
        navigate('/login');
        return;
      }

      const API_URL = 'http://localhost:3001';

      // FormData oluştur
      const formData = new FormData();
      formData.append('product_name', product.name);
      formData.append('product_katalog_name', product.category);
      formData.append('farmer_price', product.price);
      formData.append('stock_quantity', product.stock);
      
      if (product.image) {
        console.log('Adding file to FormData...');
        console.log('File being added:', product.image);
        formData.append('file', product.image);
        
        // FormData içeriğini detaylı kontrol et
        console.log('=== FormData Debug ===');
        for (let [key, value] of formData.entries()) {
          if (value instanceof File) {
            console.log(`FormData ${key}:`, {
              name: value.name,
              size: value.size,
              type: value.type,
              lastModified: value.lastModified
            });
          } else {
            console.log(`FormData ${key}:`, value);
          }
        }
      }

      console.log('Sending request to:', `${API_URL}/product`);
      const response = await fetch(`${API_URL}/product`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
        body: formData,
      });

      console.log('Response status:', response.status);
      console.log('Response headers:', response.headers);

      if (!response.ok) {
        if (response.status === 401) {
          localStorage.removeItem('token');
          localStorage.removeItem('user');
          navigate('/login');
          return;
        }
        const errorData = await response.json();
        throw new Error(errorData.message || 'Ürün eklenirken bir hata oluştu.');
      }

      const newProduct = await response.json();
      console.log('API Response:', newProduct);
      
      setProducts([...products, {
        name: newProduct.product_name,
        category: categories.find(c => c.value === newProduct.product_katalog_name)?.label || newProduct.product_katalog_name,
        price: newProduct.farmer_price,
        stock: newProduct.stock_quantity,
        id: newProduct.id,
        image_url: newProduct.image_url,
      }]);

      // Formu temizle
      setProduct({
        name: '',
        category: '',
        description: '',
        price: '',
        stock: '',
        image: '',
        imagePreview: '',
      });
    } catch (error: any) {
      console.error('Ürün eklenirken hata:', error);
      alert(error.message);
    }
  };

  // Ürün görseli yükleme (crop ile)
  const handleProductImage = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      // Dosya boyutu kontrolü (5MB)
      if (file.size > 5 * 1024 * 1024) {
        alert('Dosya boyutu 5MB\'dan küçük olmalıdır.');
        return;
      }

      // Dosya tipi kontrolü
      if (!['image/jpeg', 'image/png', 'image/webp'].includes(file.type)) {
        alert('Sadece JPEG, PNG ve WebP formatları desteklenmektedir.');
        return;
      }

      console.log('=== Original File Debug ===');
      console.log('Original file:', {
        name: file.name,
        size: file.size,
        type: file.type
      });

      // Crop için resmi URL'e çevir
      const reader = new FileReader();
      reader.onload = (e) => {
        if (e.target?.result) {
          setTempImageSrc(e.target.result as string);
          setIsCropping(true);
        }
      };
      reader.readAsDataURL(file);
    }
  };

  // Kırpılan resmi kaydet
  const handleCropSave = async () => {
    if (tempImageSrc && crop && zoom !== undefined) {
      try {
        console.log('=== Crop Save Debug ===');
        console.log('Crop settings:', { crop, zoom });
        
        const croppedImageBase64 = await getCroppedImg(tempImageSrc, crop, zoom, 1, 82);
        console.log('Cropped image base64 length:', croppedImageBase64.length);
        
        // Base64'ü File objesine çevir
        const croppedFile = base64ToFile(croppedImageBase64, `product-image-${Date.now()}.jpg`);
        console.log('Cropped file created:', {
          name: croppedFile.name,
          size: croppedFile.size,
          type: croppedFile.type
        });
        
        setProduct({ ...product, image: croppedFile });
        setIsCropping(false);
        setTempImageSrc('');
      } catch (error) {
        console.error('Crop error:', error);
        alert('Resim kırpılırken bir hata oluştu.');
      }
    }
  };

  // Çiftlik görseli ekleme
  const handleAddFarmImage = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (files && files.length > 0) {
      const newFiles = Array.from(files).filter(file => {
        // Dosya boyutu kontrolü (5MB)
        if (file.size > 5 * 1024 * 1024) {
          alert('Dosya boyutu 5MB\'dan küçük olmalıdır.');
          return false;
        }
        // Dosya tipi kontrolü
        if (!['image/jpeg', 'image/png', 'image/webp'].includes(file.type)) {
          alert('Sadece JPEG, PNG ve WebP formatları desteklenmektedir.');
          return false;
        }
        return true;
      });

      setFarmInfo(prev => ({
        ...prev,
        newImages: [...prev.newImages, ...newFiles]
      }));
    }
  };

  // Çiftlik sertifikası ekleme
  const handleAddCertificate = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (files && files.length > 0) {
      const newFiles = Array.from(files).filter(file => {
        // Dosya boyutu kontrolü (5MB)
        if (file.size > 5 * 1024 * 1024) {
          alert('Dosya boyutu 5MB\'dan küçük olmalıdır.');
          return false;
        }
        // Dosya tipi kontrolü
        const allowedMimeTypes = ['image/jpeg', 'image/png', 'application/pdf'];
        if (!allowedMimeTypes.includes(file.type)) {
          alert('Sadece JPEG, PNG ve PDF formatları desteklenmektedir.');
          return false;
        }
        return true;
      });

      setFarmInfo(prev => ({
        ...prev,
        newCertificates: [...prev.newCertificates, ...newFiles]
      }));
    }
  };

  // Mağaza bilgilerini kaydet
  const handleSaveStoreInfo = async () => {
    try {
      const token = localStorage.getItem('token');
      console.log('=== handleSaveStoreInfo Debug ===');
      console.log('Token mevcut:', !!token);
      
      if (!token) {
        navigate('/login');
        return;
      }

      const API_URL = 'http://localhost:3001';

      // 1. Biyografiyi güncelle
      if (farmInfo.farmer_biografi.trim()) {
        console.log('Biyografi güncelleyecek:', farmInfo.farmer_biografi);
        const bioResponse = await fetch(`${API_URL}/farmer/store/biography`, {
          method: 'PUT',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ farmer_biografi: farmInfo.farmer_biografi }),
        });
        console.log('Biyografi response status:', bioResponse.status);
        if (!bioResponse.ok) {
          const errorText = await bioResponse.text();
          console.error('Biyografi error:', errorText);
        }
      }

      // 2. Yeni resimleri yükle
      if (farmInfo.newImages.length > 0) {
        console.log('Yeni resimler yükleyecek:', farmInfo.newImages.length);
        const imageFormData = new FormData();
        farmInfo.newImages.forEach(image => {
          imageFormData.append('images', image);
        });

        const imageResponse = await fetch(`${API_URL}/farmer/store/images`, {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${token}`,
          },
          body: imageFormData,
        });
        console.log('Resim response status:', imageResponse.status);
        if (!imageResponse.ok) {
          const errorText = await imageResponse.text();
          console.error('Resim error:', errorText);
        }
      }

      // 3. Yeni sertifikaları yükle
      if (farmInfo.newCertificates.length > 0) {
        console.log('Yeni sertifikalar yükleyecek:', farmInfo.newCertificates.length);
        const certFormData = new FormData();
        farmInfo.newCertificates.forEach(cert => {
          certFormData.append('certificates', cert);
        });

        const certResponse = await fetch(`${API_URL}/farmer/store/certificates`, {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${token}`,
          },
          body: certFormData,
        });
        console.log('Sertifika response status:', certResponse.status);
        if (!certResponse.ok) {
          const errorText = await certResponse.text();
          console.error('Sertifika error:', errorText);
        }
      }

      alert('Mağaza bilgileri başarıyla kaydedildi!');
      
      // Yeni dosyaları temizle ve verileri yeniden çek
      setFarmInfo(prev => ({
        ...prev,
        newImages: [],
        newCertificates: []
      }));
      fetchStoreInfo();
    } catch (error: any) {
      console.error('Mağaza bilgileri kaydedilirken hata:', error);
      alert('Kaydetme sırasında bir hata oluştu.');
    }
  };

  // Resim sil
  const handleDeleteImage = async (imageId: string) => {
    try {
      const token = localStorage.getItem('token');
      if (!token) {
        navigate('/login');
        return;
      }

      const API_URL = 'http://localhost:3001';
      const response = await fetch(`${API_URL}/farmer/store/images/${imageId}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (response.ok) {
        fetchStoreInfo(); // Verileri yeniden çek
      } else {
        alert('Resim silinirken hata oluştu.');
      }
    } catch (error: any) {
      console.error('Resim silinirken hata:', error);
      alert('Resim silinirken hata oluştu.');
    }
  };

  // Sertifika sil
  const handleDeleteCertificate = async (certificateId: string) => {
    try {
      const token = localStorage.getItem('token');
      if (!token) {
        navigate('/login');
        return;
      }

      const API_URL = 'http://localhost:3001';
      const response = await fetch(`${API_URL}/farmer/store/certificates/${certificateId}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (response.ok) {
        fetchStoreInfo(); // Verileri yeniden çek
      } else {
        alert('Sertifika silinirken hata oluştu.');
      }
    } catch (error: any) {
      console.error('Sertifika silinirken hata:', error);
      alert('Sertifika silinirken hata oluştu.');
    }
  };

  // Yeni resmi listeden çıkar
  const removeNewImage = (index: number) => {
    const updatedImages = farmInfo.newImages.filter((_, i) => i !== index);
    setFarmInfo(prev => ({ ...prev, newImages: updatedImages }));
  };

  // Yeni sertifikayı listeden çıkar
  const removeNewCertificate = (index: number) => {
    const updatedCerts = farmInfo.newCertificates.filter((_, i) => i !== index);
    setFarmInfo(prev => ({ ...prev, newCertificates: updatedCerts }));
  };

  // Ürün güncelleme
  const handleUpdateProduct = async (e: React.FormEvent) => {
    e.preventDefault();
    if (editIndex === null) return;

    try {
      const token = localStorage.getItem('token');
      if (!token) {
        navigate('/login');
        return;
      }

      const productId = products[editIndex].id;
      const API_URL = 'http://localhost:3001';

      const formData = new FormData();
      formData.append('product_name', product.name);
      formData.append('product_katalog_name', product.category);
      formData.append('farmer_price', product.price);
      formData.append('stock_quantity', product.stock);
      if (product.image) {
        formData.append('file', product.image);
      }

      const response = await fetch(`${API_URL}/product/${productId}`, {
        method: 'PATCH',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
        body: formData,
      });

      if (!response.ok) {
        if (response.status === 401) {
          localStorage.removeItem('token');
          localStorage.removeItem('user');
          navigate('/login');
          return;
        }
        const errorData = await response.json();
        throw new Error(errorData.message || 'Ürün güncellenirken bir hata oluştu.');
      }

      const updatedProduct = await response.json();
      const updatedProducts = [...products];
      updatedProducts[editIndex] = {
        name: updatedProduct.product_name,
        category: categories.find(c => c.value === updatedProduct.product_katalog_name)?.label || updatedProduct.product_katalog_name,
        price: updatedProduct.farmer_price,
        stock: updatedProduct.stock_quantity,
        id: updatedProduct.id,
        image_url: updatedProduct.image_url,
      };

      setProducts(updatedProducts);
      setEditMode(false);
      setEditIndex(null);
      setProduct({
        name: '',
        category: '',
        description: '',
        price: '',
        stock: '',
        image: '',
        imagePreview: '',
      });
    } catch (error: any) {
      console.error('Ürün güncellenirken hata:', error);
      alert(error.message);
    }
  };

  // Düzenleme butonuna tıklandığında
  const handleEdit = (index: number) => {
    const p = products[index];
    setProduct({
      name: p.name,
      category: categories.find(c => c.label === p.category)?.value || '',
      description: '',
      price: p.price.toString(),
      stock: p.stock.toString(),
      image: '',
      imagePreview: '',
    });
    setEditMode(true);
    setEditIndex(index);
  };

  // Ürün silme
  const handleDelete = async (idx: number) => {
    try {
      const token = localStorage.getItem('token');
      if (!token) {
        navigate('/login');
        return;
      }

      const productId = products[idx].id;
      const API_URL = 'http://localhost:3001';

      const response = await fetch(`${API_URL}/product/${productId}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        if (response.status === 401) {
          localStorage.removeItem('token');
          localStorage.removeItem('user');
          navigate('/login');
          return;
        }
        const errorData = await response.json();
        throw new Error(errorData.message || 'Ürün silinirken bir hata oluştu.');
      }

      const updatedProducts = products.filter((_, index) => index !== idx);
      setProducts(updatedProducts);
    } catch (error: any) {
      console.error('Ürün silinirken hata:', error);
      alert(error.message);
    }
  };

  // Menü açılıp kapanma efekti
  useEffect(() => {
    const sidebar = document.querySelector('.dashboard-sidebar');
    if (sidebar) {
      if (isMobileMenuOpen) {
        sidebar.classList.add('mobile-menu-open');
        document.body.style.overflow = 'hidden';
      } else {
        sidebar.classList.remove('mobile-menu-open');
        document.body.style.overflow = '';
      }
    }
  }, [isMobileMenuOpen]);

  // Menü dışına tıklandığında kapanma
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      const sidebar = document.querySelector('.dashboard-sidebar');
      const menuButton = document.querySelector('.mobile-menu-button');
      
      if (isMobileMenuOpen && 
          sidebar && 
          !sidebar.contains(event.target as Node) && 
          menuButton && 
          !menuButton.contains(event.target as Node)) {
        setIsMobileMenuOpen(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, [isMobileMenuOpen]);

  // Component yüklendiğinde ürünleri ve mağaza bilgilerini çek
  useEffect(() => {
    const token = localStorage.getItem('token');
    console.log('=== Dashboard useEffect ===');
    console.log('Token mevcut:', !!token);
    console.log('Token uzunluğu:', token?.length);
    console.log('Token ilk 50 karakter:', token?.substring(0, 50));
    
    if (token) {
      fetchProducts();
      fetchStoreInfo();
    } else {
      console.log('Token yok, login sayfasına yönlendiriliyor');
      navigate('/login');
    }
  }, [navigate, fetchProducts, fetchStoreInfo]);

  // Logout fonksiyonu
  const handleLogout = async () => {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    navigate('/login');
  };

  if (!supabase) {
    return <div>Yapılandırma hatası: Supabase bağlantısı kurulamadı</div>;
  }

  return (
    <div style={{ display: 'flex', minHeight: '100vh', background: '#FAF8F3' }} className={`dashboard-container ${isMobileMenuOpen ? 'mobile-menu-open' : ''}`}>
      {/* Hamburger Menü Butonu - Sadece mobilde görünür */}
      <button 
        onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
        style={{
          display: 'none',
          position: 'fixed',
          top: 16,
          left: 16,
          zIndex: 1000,
          background: '#F5F2EA',
          border: 'none',
          borderRadius: 8,
          padding: 8,
          cursor: 'pointer',
          boxShadow: '0 2px 8px #0002'
        }}
        className="mobile-menu-button"
      >
        <div style={{ width: 24, height: 2, background: '#A18249', margin: '4px 0' }}></div>
        <div style={{ width: 24, height: 2, background: '#A18249', margin: '4px 0' }}></div>
        <div style={{ width: 24, height: 2, background: '#A18249', margin: '4px 0' }}></div>
      </button>

      {/* Sol Menü / Mobil Menü */}
      <aside style={{ 
        width: 220, 
        background: '#F5F2EA', 
        padding: 24, 
        display: 'flex', 
        flexDirection: 'column', 
        gap: 16,
        transition: 'all 0.3s ease',
        position: 'relative',
        zIndex: 100
      }} className="dashboard-sidebar">
        <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 32 }}>
          <img src={require('../assets/brand-logo.png')} alt="logo" style={{ width: 40, borderRadius: '50%' }} />
          <div>
            <div style={{ fontWeight: 700, fontSize: 16 }}>Hoş Geldin</div>
            <div style={{ fontSize: 13, color: '#A18249' }}>Hasan Gürbüz</div>
          </div>
        </div>
        <button style={tab==='product'?menuActive:menuBtn} onClick={()=>setTab('product')}>Panelim</button>
        <button style={tab==='farm'?menuActive:menuBtn} onClick={()=>setTab('farm')}>Çiftliğim</button>
        <button style={logoutBtn} onClick={handleLogout}>Çıkış</button>
      </aside>

      {/* Ana İçerik */}
      <main style={{ flex: 1, padding: '32px 48px' }} className="dashboard-main-content">
        {/* Üst Menü */}
        <nav style={{ 
          display: 'flex', 
          justifyContent: 'space-between', 
          alignItems: 'center', 
          width: '100%',
          marginBottom: 24,
          padding: '16px 0',
          borderBottom: '1px solid #E9DFCE'
        }} className="dashboard-top-nav-large">
          <div style={{ display: 'flex', alignItems: 'center', gap: 32 }}>
            <h1 style={{ fontSize: 36, fontWeight: 800, margin: 0 }}>Satış Panelim</h1>
            <div style={{ color: '#A18249' }}>Ürünlerinizi ve Çiftliğinizi Yönetin</div>
          </div>
        </nav>
        {/* Tab menü */}
        <div style={{ display: 'flex', gap: 32, borderBottom: '1px solid #E9DFCE', marginBottom: 32 }} className="dashboard-tabs">
          <button style={tab==='product'?tabActive:tabBtn} onClick={()=>setTab('product')}>Ürün Yönetimi</button>
          <button style={tab==='farm'?tabActive:tabBtn} onClick={()=>setTab('farm')}>Mağaza Bilgileriniz</button>
        </div>
        {/* İçerik */}
        {tab==='product' ? (
          <section>
            {/* Ürün Ekleme Formu */}
            <form onSubmit={editMode ? handleUpdateProduct : handleAddProduct} style={{ display: 'flex', flexDirection: 'column', gap: 16, maxWidth: 600 }}>
              <label>Ürün İsmi
                <input className="form-input" style={inputStyle} value={product.name} onChange={e=>setProduct({...product, name:e.target.value})} required />
              </label>
              <label>Ürünün Kategorisi
                <select className="form-input" style={inputStyle} value={product.category} onChange={e=>setProduct({...product, category:e.target.value})} required>
                  {categories.map(c=>(<option key={c.value} value={c.value}>{c.label}</option>))}
                </select>
              </label>
              <div style={{ display: 'flex', gap: 16 }}>
                <label style={{ flex: 1 }}>Fiyatı
                  <input className="form-input" style={inputStyle} type="number" min="0" step="0.01" value={product.price} onChange={e=>setProduct({...product, price:e.target.value})} required />
                </label>
                <label style={{ flex: 1 }}>Stok Miktarı
                  <input className="form-input" style={inputStyle} type="number" min="0" value={product.stock} onChange={e=>setProduct({...product, stock:e.target.value})} required />
                </label>
              </div>
              <label>Ürünün Resmi
                <input type="file" accept="image/*" onChange={handleProductImage} />
              </label>
              {product.image && product.image instanceof File && (
                <div style={{ marginBottom: 16 }}>
                  <p style={{ fontSize: 14, color: '#666', marginBottom: 8 }}>Önizleme (82x82):</p>
                  <img 
                    src={URL.createObjectURL(product.image)} 
                    alt="preview" 
                    style={{ width: 82, height: 82, objectFit: 'cover', borderRadius: 12, border: '2px solid #E9DFCE' }} 
                  />
                </div>
              )}
              <button type="submit" style={greenBtn}>{editMode ? 'Ürünü Güncelle' : 'Ürünü Mağazana Yükle'}</button>
            </form>
            {/* Crop Modal */}
            {isCropping && (
              <div style={{ position: 'fixed', top:0, left:0, width:'100vw', height:'100vh', background:'#0008', zIndex:1000, display:'flex', alignItems:'center', justifyContent:'center' }}>
                <div style={{ background:'#fff', padding:32, borderRadius:16, boxShadow:'0 2px 16px #0003', position:'relative' }}>
                  <h3>Fotoğrafı Kırp (82x82)</h3>
                  <div style={{ position:'relative', width:300, height:300, background:'#eee', marginBottom:16 }}>
                    <Cropper
                      image={tempImageSrc}
                      crop={crop}
                      zoom={zoom}
                      aspect={1}
                      cropShape="rect"
                      showGrid={false}
                      onCropChange={setCrop}
                      onZoomChange={setZoom}
                      onCropComplete={onCropComplete}
                      minZoom={1}
                      maxZoom={3}
                    />
                  </div>
                  <div style={{ display:'flex', gap:16, justifyContent:'flex-end' }}>
                    <button onClick={()=>{setIsCropping(false); setTempImageSrc('');}} style={{...greenBtn, background:'#ccc', color:'#222'}}>İptal</button>
                    <button onClick={handleCropSave} style={greenBtn}>Kırp ve Yükle</button>
                  </div>
                </div>
              </div>
            )}
            {/* Ürün Listesi */}
            <div style={{ marginTop: 32 }}>
              <h2 style={{ fontSize: 20, fontWeight: 700, marginBottom: 16 }}>Mevcut Ürünlerim</h2>
              
              {/* Desktop Table */}
              <table style={{ width: '100%', border: '1px solid #E9DFCE', borderRadius: 8, overflow: 'hidden', background: '#fff' }} className="desktop-table">
                <thead>
                  <tr style={{ background: '#F5F2EA' }}>
                    <th style={thTd}>Ürün Resmi</th>
                    <th style={thTd}>Ürün Adı</th>
                    <th style={thTd}>Kategori</th>
                    <th style={thTd}>Fiyat</th>
                    <th style={thTd}>Stok</th>
                    <th style={thTd}>İşlemler</th>
                  </tr>
                </thead>
                <tbody>
              {products.map((product, idx) => (
                    <tr key={product.id} style={{ borderBottom: '1px solid #E9DFCE' }}>
                      <td style={thTd}>
                        {product.image_url ? (
                    <img
                      src={product.image_url}
                      alt={product.name}
                            style={{ width: 60, height: 60, objectFit: 'cover', borderRadius: 8 }} 
                          />
                        ) : (
                          <div style={{ width: 60, height: 60, background: '#f0f0f0', borderRadius: 8, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 12, color: '#999' }}>
                            Resim Yok
                          </div>
                        )}
                      </td>
                      <td style={thTd}>{product.name}</td>
                      <td style={thTd}>{product.category}</td>
                      <td style={thTd}>{product.price} TL</td>
                      <td style={thTd}>{product.stock}</td>
                      <td style={thTd}>
                        <button style={editBtn} onClick={() => handleEdit(idx)}>Düzenle</button>
                        <button style={deleteBtn} onClick={() => handleDelete(idx)}>Sil</button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>

              {/* Mobile Cards */}
              <div className="mobile-cards" style={{ display: 'none' }}>
                {products.map((product, idx) => (
                  <div key={product.id} style={{ 
                    background: '#fff', 
                    border: '1px solid #E9DFCE', 
                    borderRadius: 12, 
                    padding: 16, 
                    marginBottom: 16,
                    boxShadow: '0 2px 4px rgba(0,0,0,0.1)'
                  }}>
                    <div style={{ display: 'flex', gap: 16, marginBottom: 16 }}>
                      {product.image_url ? (
                        <img 
                          src={product.image_url} 
                          alt={product.name} 
                          style={{ width: 80, height: 80, objectFit: 'cover', borderRadius: 8, flexShrink: 0 }} 
                        />
                      ) : (
                        <div style={{ 
                          width: 80, 
                          height: 80, 
                          background: '#f0f0f0', 
                          borderRadius: 8, 
                          display: 'flex', 
                          alignItems: 'center', 
                          justifyContent: 'center', 
                          fontSize: 12, 
                          color: '#999',
                          flexShrink: 0
                        }}>
                          Resim Yok
                        </div>
                      )}
                      <div style={{ flex: 1 }}>
                        <h3 style={{ margin: '0 0 12px 0', fontSize: 18, fontWeight: 600, color: '#333' }}>
                          {product.name}
                        </h3>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 8 }}>
                          <span style={{ fontSize: 14, color: '#666', fontWeight: 500 }}>Kategori:</span>
                          <span style={{ fontSize: 14, color: '#333', fontWeight: 600 }}>{product.category}</span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 8 }}>
                          <span style={{ fontSize: 14, color: '#666', fontWeight: 500 }}>Fiyat:</span>
                          <span style={{ fontSize: 14, color: '#40693E', fontWeight: 700 }}>{product.price} TL</span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                          <span style={{ fontSize: 14, color: '#666', fontWeight: 500 }}>Stok:</span>
                          <span style={{ fontSize: 14, color: '#333', fontWeight: 600 }}>{product.stock}</span>
                        </div>
                      </div>
                    </div>
                    <div style={{ display: 'flex', gap: 8, justifyContent: 'flex-end' }}>
                      <button
                        style={{ ...editBtn, minWidth: 80 }} 
                        onClick={() => handleEdit(idx)}
                      >
                        Düzenle
                      </button>
                      <button
                        style={{ ...deleteBtn, minWidth: 60 }} 
                        onClick={() => handleDelete(idx)}
                      >
                        Sil
                      </button>
                  </div>
                </div>
              ))}
              </div>

              {products.length === 0 && (
                <div style={{ textAlign: 'center', padding: 32, color: '#999' }}>
                  Henüz ürün eklenmemiş.
                </div>
              )}
            </div>
          </section>
        ) : (
          <section style={{ maxWidth: 800 }}>
            <h2 style={{ fontWeight: 700, fontSize: 24, marginBottom: 24 }}>Çiftlik Bilgileri</h2>
            
            {/* Biyografi */}
            <div style={{ marginBottom: 32 }}>
              <label style={{ display: 'block', marginBottom: 8, fontWeight: 600 }}>Ön Yazı (Çiftlik Hakkında)</label>
              <textarea 
                className="form-input" 
                style={{...inputStyle, minHeight: 100}} 
                value={farmInfo.farmer_biografi} 
                onChange={e=>setFarmInfo({...farmInfo, farmer_biografi:e.target.value})}
                placeholder="Çiftliğiniz hakkında bilgi verin..."
              />
            </div>

            {/* Çiftlik Fotoğrafları */}
            <div style={{ marginBottom: 32 }}>
              <label style={{ display: 'block', marginBottom: 16, fontWeight: 600 }}>Çiftlik Fotoğrafları</label>
              
              {/* Mevcut Resimler */}
              {farmInfo.images.length > 0 && (
                <div style={{ marginBottom: 16 }}>
                  <h4 style={{ marginBottom: 12, color: '#666' }}>Mevcut Resimler:</h4>
                  <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(150px, 1fr))', gap: 16 }}>
                    {farmInfo.images.map((image, idx) => (
                      <div key={image.id} style={{ position: 'relative' }}>
                        <img 
                          src={image.farmer_image} 
                          alt={`Çiftlik resmi ${idx + 1}`}
                          style={{ width: '100%', height: 150, objectFit: 'cover', borderRadius: 8, border: '2px solid #E9DFCE' }}
                        />
                        <button
                          onClick={() => handleDeleteImage(image.id)}
                          style={{
                            position: 'absolute',
                            top: 8,
                            right: 8,
                            background: '#dc3545',
                            color: 'white',
                            border: 'none',
                            borderRadius: '50%',
                            width: 24,
                            height: 24,
                            cursor: 'pointer',
                            fontSize: 12
                          }}
                        >
                          ×
                        </button>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* Yeni Resimler */}
              {farmInfo.newImages.length > 0 && (
                <div style={{ marginBottom: 16 }}>
                  <h4 style={{ marginBottom: 12, color: '#666' }}>Yüklenecek Resimler:</h4>
                  <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(150px, 1fr))', gap: 16 }}>
                    {farmInfo.newImages.map((image, idx) => (
                      <div key={idx} style={{ position: 'relative' }}>
                        <img 
                          src={URL.createObjectURL(image)} 
                          alt={`Yeni resim ${idx + 1}`}
                          style={{ width: '100%', height: 150, objectFit: 'cover', borderRadius: 8, border: '2px solid #40693E' }}
                        />
                        <button
                          onClick={() => removeNewImage(idx)}
                          style={{
                            position: 'absolute',
                            top: 8,
                            right: 8,
                            background: '#dc3545',
                            color: 'white',
                            border: 'none',
                            borderRadius: '50%',
                            width: 24,
                            height: 24,
                            cursor: 'pointer',
                            fontSize: 12
                          }}
                        >
                          ×
                        </button>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* Resim Ekleme Butonu */}
              <div style={{ 
                border: '2px dashed #E9DFCE', 
                borderRadius: 8, 
                padding: 32, 
                textAlign: 'center',
                background: '#fafafa',
                cursor: 'pointer',
                transition: 'all 0.3s ease'
              }}
              onClick={() => document.getElementById('farmImages')?.click()}
              >
                <div style={{ fontSize: 48, color: '#ccc', marginBottom: 8 }}>+</div>
                <div style={{ color: '#666' }}>Çiftlik fotoğrafı eklemek için tıklayın</div>
                <div style={{ fontSize: 12, color: '#999', marginTop: 4 }}>JPEG, PNG, WebP - Maksimum 5MB</div>
              </div>
              <input 
                id="farmImages"
                type="file" 
                accept="image/*" 
                multiple
                onChange={handleAddFarmImage} 
                style={{ display: 'none' }}
              />
            </div>

            {/* Sertifikalar */}
            <div style={{ marginBottom: 32 }}>
              <label style={{ display: 'block', marginBottom: 16, fontWeight: 600 }}>Sertifikalarım</label>
              
              {/* Mevcut Sertifikalar */}
              {farmInfo.certificates.length > 0 && (
                <div style={{ marginBottom: 16 }}>
                  <h4 style={{ marginBottom: 12, color: '#666' }}>Mevcut Sertifikalar:</h4>
                  <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                    {farmInfo.certificates.map((cert, idx) => (
                      <div key={cert.id} style={{ 
                        display: 'flex', 
                        alignItems: 'center', 
                        justifyContent: 'space-between',
                        padding: 12,
                        border: '1px solid #E9DFCE',
                        borderRadius: 8,
                        background: '#fff'
                      }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                          <div style={{ 
                            padding: 8,
                            background: '#f8f9fa',
                            borderRadius: 4,
                            fontSize: 12,
                            fontWeight: 600,
                            color: '#495057'
                          }}>
                            {cert.images.includes('.pdf') ? 'PDF' : 'IMG'}
                          </div>
                          <span>Sertifika {idx + 1}</span>
                        </div>
                        <div style={{ display: 'flex', gap: 8 }}>
                          <button 
                            onClick={() => window.open(cert.images, '_blank')}
                            style={{
                              background: '#40693E',
                              color: 'white',
                              border: 'none',
                              borderRadius: 4,
                              padding: '6px 12px',
                              cursor: 'pointer',
                              fontSize: 12
                            }}
                          >
                            Görüntüle
                          </button>
                          <button
                            onClick={() => handleDeleteCertificate(cert.id)}
                            style={{
                              background: '#dc3545',
                              color: 'white',
                              border: 'none',
                              borderRadius: 4,
                              padding: '6px 12px',
                              cursor: 'pointer',
                              fontSize: 12
                            }}
                          >
                            Sil
                          </button>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* Yeni Sertifikalar */}
              {farmInfo.newCertificates.length > 0 && (
                <div style={{ marginBottom: 16 }}>
                  <h4 style={{ marginBottom: 12, color: '#666' }}>Yüklenecek Sertifikalar:</h4>
                  <div style={{ display: 'flex', flexDirection: 'column', gap: 12 }}>
                    {farmInfo.newCertificates.map((cert, idx) => (
                      <div key={idx} style={{ 
                        display: 'flex', 
                        alignItems: 'center', 
                        justifyContent: 'space-between',
                        padding: 12,
                        border: '2px solid #40693E',
                        borderRadius: 8,
                        background: '#f8fff8'
                      }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                          <div style={{ 
                            padding: 8,
                            background: '#40693E',
                            borderRadius: 4,
                            fontSize: 12,
                            fontWeight: 600,
                            color: 'white'
                          }}>
                            {cert.type.includes('pdf') ? 'PDF' : 'IMG'}
                          </div>
                          <span>{cert.name}</span>
                        </div>
                        <button
                          onClick={() => removeNewCertificate(idx)}
                          style={{
                            background: '#dc3545',
                            color: 'white',
                            border: 'none',
                            borderRadius: 4,
                            padding: '6px 12px',
                            cursor: 'pointer',
                            fontSize: 12
                          }}
                        >
                          Kaldır
                        </button>
                      </div>
                    ))}
                  </div>
                </div>
              )}

              {/* Sertifika Ekleme Butonu */}
              <div style={{ 
                border: '2px dashed #E9DFCE', 
                borderRadius: 8, 
                padding: 32, 
                textAlign: 'center',
                background: '#fafafa',
                cursor: 'pointer',
                transition: 'all 0.3s ease'
              }}
              onClick={() => document.getElementById('farmCertificates')?.click()}
              >
                <div style={{ fontSize: 48, color: '#ccc', marginBottom: 8 }}>📄</div>
                <div style={{ color: '#666' }}>Sertifika eklemek için tıklayın</div>
                <div style={{ fontSize: 12, color: '#999', marginTop: 4 }}>PDF, JPEG, PNG - Maksimum 5MB</div>
              </div>
              <input 
                id="farmCertificates"
                type="file" 
                accept="application/pdf,image/*" 
                multiple
                onChange={handleAddCertificate} 
                style={{ display: 'none' }}
              />
            </div>

            {/* Kaydet Butonu */}
            <button 
              onClick={handleSaveStoreInfo}
              style={{
                ...greenBtn,
                width: '100%',
                marginTop: 16
              }}
            >
              Mağaza Bilgilerini Kaydet
            </button>
          </section>
        )}
      </main>

      {/* Mobil Menü Overlay */}
      <div 
        style={{
          display: 'none',
          position: 'fixed',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          background: '#0008',
          zIndex: 90,
          opacity: isMobileMenuOpen ? 1 : 0,
          visibility: isMobileMenuOpen ? 'visible' : 'hidden',
          transition: 'all 0.3s ease'
        }}
        className="mobile-menu-overlay"
        onClick={() => setIsMobileMenuOpen(false)}
      />
    </div>
  );
}

// Stiller
const inputStyle = {
  width: '100%',
  padding: '12px 16px',
  border: '1px solid #E9DFCE',
  borderRadius: 8,
  fontSize: 16,
  marginTop: 4,
  marginBottom: 8,
  background: '#fff',
};
const menuBtn = {
  background: 'none',
  border: 'none',
  textAlign: 'left' as const,
  fontSize: 18,
  color: '#A18249',
  padding: '8px 0',
  cursor: 'pointer',
  borderRadius: 8,
};
const menuActive = {
  ...menuBtn,
  background: '#E9DFCE',
  color: '#000',
  fontWeight: 700,
};
const logoutBtn = {
  background: '#fff',
  color: '#40693E',
  border: '1px solid #40693E',
  borderRadius: 8,
  padding: '8px 24px',
  fontWeight: 700,
  cursor: 'pointer',
};
const tabBtn = {
  background: 'none',
  border: 'none',
  color: '#A18249',
  fontWeight: 600,
  fontSize: 18,
  padding: '12px 24px',
  cursor: 'pointer',
};
const tabActive = {
  ...tabBtn,
  color: '#40693E',
  borderBottom: '3px solid #40693E',
};
const greenBtn = {
  background: '#1DB954',
  color: '#fff',
  border: 'none',
  borderRadius: 8,
  padding: '12px 0',
  fontWeight: 700,
  fontSize: 18,
  marginTop: 8,
  cursor: 'pointer',
};
const thTd = {
  padding: '14px 8px',
};
const editBtn = {
  background: '#E9DFCE',
  color: '#40693E',
  border: 'none',
  borderRadius: 6,
  padding: '4px 12px',
  marginRight: 8,
  cursor: 'pointer',
};
const deleteBtn = {
  background: '#F8D7DA',
  color: '#B71C1C',
  border: 'none',
  borderRadius: 6,
  padding: '4px 12px',
  cursor: 'pointer',
};

// Mobil ve tablet uyumlu stiller için media query
const styleSheet = document.createElement('style');
styleSheet.innerHTML = `
  /* Büyük ekranlarda yan menü */
  .dashboard-sidebar {
    display: flex;
  }

  /* Desktop'ta card'ları gizle, tablo göster */
  .desktop-table {
    display: table;
  }
  
  .mobile-cards {
    display: none !important;
  }

  /* Tablet ve daha küçük ekranlar için */
  @media (max-width: 768px) {
    .dashboard-container {
      flex-direction: column;
    }

    .mobile-menu-button {
      display: block !important;
    }

    .dashboard-sidebar {
      position: fixed;
      top: 0;
      left: -280px;
      height: 100vh;
      width: 280px;
      padding: 80px 24px 24px;
      transition: left 0.3s ease;
      box-shadow: 2px 0 8px #0002;
    }

    .dashboard-sidebar.mobile-menu-open {
      left: 0;
    }

    .dashboard-main-content {
      padding: 12px;
      margin-top:-1000px;
      width: 100%;
      box-sizing: border-box;
      transform: translateX(0);
      transition: transform 0.3s ease;
      flex: none;
    }

    .dashboard-top-nav-large {
      flex-direction: column;
      gap: 16px;
      text-align: center;
      padding: 8px 0;
    }

    .dashboard-top-nav-large > div {
      flex-direction: column;
      gap: 8px;
    }

    .dashboard-top-nav-large h1 {
      font-size: 28px;
    }

    .dashboard-tabs {
      flex-direction: column;
      gap: 16px;
    }

    /* Form içindeki yan yana duran öğeler */
    .form-row-responsive {
      flex-direction: column;
      gap: 0 !important;
    }

    .form-row-responsive label {
      flex: unset !important;
      width: 100%;
      margin-bottom: 8px;
    }
    
    /* Menü açıkken ana içeriği sağa kaydırma */
    .dashboard-container.mobile-menu-open .dashboard-main-content {
    }

    /* Genel olarak ana içerikteki öğelerin taşmasını engelle */
    .dashboard-main-content * {
        box-sizing: border-box;
    }

    /* Mobilde tablo gizle, card göster */
    .desktop-table {
      display: none !important;
    }
    
    .mobile-cards {
      display: block !important;
    }

  }

  /* Sadece telefonlar için */
  @media (max-width: 480px) {
    .dashboard-main-content {
      padding: 8px;
      margin-top:-1000px;
      width: 100%;
      box-sizing: border-box;
      transform: translateX(0);
      transition: transform 0.3s ease;
      flex: none;
    }

    /* Telefon görünümünde menü açıkken ana içeriği sağa kaydırma */
    .dashboard-container.mobile-menu-open .dashboard-main-content {
    }

    .dashboard-top-nav-large {
      padding: 4px 0;
    }

    .dashboard-tabs {
      flex-direction: column;
      gap: 12px;
      align-items: stretch;
    }

    .dashboard-tabs button {
      text-align: center;
      padding: 12px 0;
    }

    .dashboard-sidebar {
      width: 100%;
      left: -100%;
    }

    /* Form içindeki yan yana duran öğeler (telefon) */
    .form-row-responsive {
      flex-direction: column;
      gap: 0 !important;
    }

    .form-row-responsive label {
      flex: unset !important;
      width: 100%;
      margin-bottom: 8px;
     }
     
     /* Genel olarak ana içerikteki öğelerin taşmasını engelle (telefon) */
    .dashboard-main-content * {
        box-sizing: border-box;
    }

    /* Telefon için card'ların iç boşluklarını azalt */
    .mobile-cards > div {
      padding: 12px !important;
      margin-bottom: 12px !important;
    }

    .mobile-cards img,
    .mobile-cards > div > div:first-child > div:first-child {
      width: 60px !important;
      height: 60px !important;
    }

    .mobile-cards h3 {
      font-size: 16px !important;
    }

    .mobile-cards p {
      font-size: 13px !important;
    }
  }

  /* Menü açıkken body'nin scroll'unu engelle */
  .mobile-menu-open body {
      overflow: hidden;
  }
`;

if (typeof window !== 'undefined' && !document.getElementById('dashboard-styles')) {
  styleSheet.id = 'dashboard-styles';
  document.head.appendChild(styleSheet);
}
