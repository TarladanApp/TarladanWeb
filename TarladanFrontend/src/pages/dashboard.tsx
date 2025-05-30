import React, { useState, useCallback, useEffect } from 'react';
import Cropper from 'react-easy-crop';
import { useNavigate } from 'react-router-dom';
import { createClient } from '@supabase/supabase-js';

const categories = [
  { value: '', label: 'Select' },
  { value: 'vegetable', label: 'Vegetable' },
  { value: 'fruit', label: 'Fruit' },
  { value: 'grain', label: 'Grain' },
];

const initialProducts: any[] = []; // Başlangıçta boş dizi

function getCroppedImg(imageSrc: string, crop: any, zoom: number, aspect: number, size = 82) {
  return new Promise<string>((resolve, reject) => {
    const image = new window.Image();
    image.src = imageSrc;
    image.onload = () => {
      const canvas = document.createElement('canvas');
      const ctx = canvas.getContext('2d');
      if (!ctx) return reject('No ctx');
      const scaleX = image.naturalWidth / image.width;
      const scaleY = image.naturalHeight / image.height;
      canvas.width = size;
      canvas.height = size;
      const sx = crop.x * scaleX;
      const sy = crop.y * scaleY;
      const sw = crop.width * scaleX;
      const sh = crop.height * scaleY;
      ctx.drawImage(image, sx, sy, sw, sh, 0, 0, size, size);
      resolve(canvas.toDataURL('image/jpeg'));
    };
    image.onerror = reject;
  });
}

export default function Dashboard() {
  const [product, setProduct] = useState({
    name: '',
    category: '',
    description: '',
    price: '',
    stock: '',
    image: '',
    imagePreview: '',
  });
  const [products, setProducts] = useState(initialProducts);
  const [farmInfo, setFarmInfo] = useState<{ intro: string; image: File | null; imagePreview: string | null; cert: File | null }>(
    {
    intro: '',
      image: null,
      imagePreview: null,
      cert: null,
    }
  );
  const [tab, setTab] = useState<'product' | 'farm'>('product');
  const [cropModal, setCropModal] = useState(false);
  const [cropImg, setCropImg] = useState('');
  const [crop, setCrop] = useState({ x: 0, y: 0 });
  const [zoom, setZoom] = useState(1);
  const [croppedAreaPixels, setCroppedAreaPixels] = useState<any>(null);
  const [editMode, setEditMode] = useState(false);
  const [editIndex, setEditIndex] = useState<number | null>(null);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  const navigate = useNavigate();

  // Supabase client instance
  const supabaseUrl = process.env.REACT_APP_SUPABASE_URL || '';
  const supabaseKey = process.env.REACT_APP_SUPABASE_KEY || '';
  const supabase = createClient(supabaseUrl, supabaseKey);

  // Ürünleri backend'den çekme fonksiyonu
  const fetchProducts = async (farmerId: string, authToken: string) => {
    try {
      // TODO: Backend API URL'ini buraya ekleyin veya env dosyasından alın
      const response = await fetch(`YOUR_BACKEND_API_URL/product/farmer/${farmerId}`, {
        method: 'GET',
        headers: {
          'Authorization': `Bearer ${authToken}`,
        },
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.message || 'Ürünler getirilirken bir hata oluştu.');
      }

      const productsData = await response.json();
      console.log('Ürünler başarıyla getirildi:', productsData);

      // Backend'den gelen ürün listesini state'e yükle
      // TODO: Backend'den gelen product_id'yi de state'e dahil et
      setProducts(productsData.map((p: any) => ({
        name: p.product_name,
        category: p.product_katalog_name,
        price: p.farmer_price,
        stock: p.stock_quantity,
        id: p.product_id, // product_id eklendi
      })));

    } catch (error: any) {
      //alert(`Ürünler getirilirken hata oluştu`);
    }
  };

  // Component yüklendiğinde veya kullanıcı session'ı değiştiğinde ürünleri çek
  useEffect(() => {
    const getProducts = async () => {
      const { data: { session } } = await supabase.auth.getSession();
      const farmerId = session?.user?.id; // Supabase user id farmer_id olarak kullanılabilir
      const authToken = session?.access_token;

      if (farmerId && authToken) {
        fetchProducts(farmerId, authToken);
      } else {
        // Kullanıcı login değilse veya session yoksa ürün listesini temizle
        setProducts([]);
        // İsteğe bağlı: Kullanıcıyı login sayfasına yönlendir
        // navigate('/login');
      }
    };

    getProducts();

    // Supabase auth state değişimlerini dinle (isteğe bağlı ama iyi olur)
    const { data: authListener } = supabase.auth.onAuthStateChange((_event, session) => {
      // Session değiştiğinde ürünleri tekrar çek
      const farmerId = session?.user?.id;
      const authToken = session?.access_token;
      if (farmerId && authToken) {
         fetchProducts(farmerId, authToken);
      } else {
         setProducts([]);
      }
    });

    // Component unmount edildiğinde listener'ı temizle
    return () => {
      authListener?.subscription.unsubscribe();
    };

  }, [supabase, navigate]); // Dependency array'e supabase ve navigate eklendi

  // Logout fonksiyonu
  const handleLogout = async () => {
    const { error } = await supabase.auth.signOut();
    if (error) {
      console.error('Çıkış yaparken hata:', error);
      alert('Çıkış yapılırken bir hata oluştu.');
    } else {
      // Çıkış başarılı, login sayfasına yönlendir
      navigate('/login');
    }
  };

  // Ürün ekleme
  const handleAddProduct = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) {
        throw new Error('Oturum bulunamadı');
      }

      const farmerId = session.user.id;
      const authToken = session.access_token;

      // 1. Önce ürün bilgilerini (resimsiz) gönder
      const productPayload = {
        product_katalog_name: categories.find(c => c.value === product.category)?.label || '',
        farmer_price: parseFloat(product.price),
        product_name: product.name,
        stock_quantity: parseInt(product.stock),
      };

      const productResponse = await fetch(`${process.env.REACT_APP_API_URL}/product`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${authToken}`,
        },
        body: JSON.stringify(productPayload),
      });

      if (!productResponse.ok) {
        const errorData = await productResponse.json();
        throw new Error(errorData.message || 'Ürün eklenirken bir hata oluştu.');
      }

      const newProduct = await productResponse.json();
      console.log('Ürün başarıyla eklendi:', newProduct);

      // 2. Eğer resim varsa, ayrı bir istek ile resmi yükle
      if (product.image) {
        const formData = new FormData();
        formData.append('image', product.image);

        const imageResponse = await fetch(`${process.env.REACT_APP_API_URL}/product/${newProduct.product_id}/image`, {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${authToken}`,
          },
          body: formData,
        });

        if (!imageResponse.ok) {
          const errorData = await imageResponse.json();
          throw new Error(errorData.message || 'Resim yüklenirken bir hata oluştu.');
        }

        const imageData = await imageResponse.json();
        console.log('Resim başarıyla yüklendi:', imageData);
      }

      // Ürün listesini güncelle
      setProducts(prevProducts => [...prevProducts, {
        id: newProduct.product_id,
        name: newProduct.product_name,
        category: newProduct.product_katalog_name,
        price: newProduct.farmer_price,
        stock: newProduct.stock_quantity,
        image: product.image
      }]);

      // Formu temizle
      setProduct({ 
        name: '', 
        category: '', 
        description: '', 
        price: '', 
        stock: '', 
        image: '', 
        imagePreview: '' 
      });

      alert('Ürün başarıyla eklendi!');

    } catch (error: any) {
      console.error('Ürün ekleme hatası:', error.message);
      alert(`Ürün eklenirken hata oluştu: ${error.message}`);
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

      const reader = new FileReader();
      reader.onload = () => {
        setCropImg(reader.result as string);
        setCropModal(true);
      };
      reader.readAsDataURL(file);
    }
  };

  const onCropComplete = useCallback((croppedArea, croppedAreaPixels) => {
    setCroppedAreaPixels(croppedAreaPixels);
  }, []);

  const handleCropSave = async () => {
    if (cropImg && croppedAreaPixels) {
      try {
        const cropped = await getCroppedImg(cropImg, croppedAreaPixels, zoom, 1, 82);
        setProduct({ ...product, image: cropped, imagePreview: cropped });
        setCropModal(false);
        setCropImg('');
      } catch (error) {
        console.error('Görsel kırpma hatası:', error);
        alert('Görsel kırpılırken bir hata oluştu.');
      }
    }
  };

  // Çiftlik görseli yükleme
  const handleFarmImage = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      setFarmInfo({ ...farmInfo, image: file, imagePreview: URL.createObjectURL(file) });
    }
  };

  // Sertifika yükleme
  const handleCert = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      setFarmInfo({ ...farmInfo, cert: file });
    }
  };

  // Ürün güncelleme
  const handleUpdateProduct = async (e: React.FormEvent) => {
    e.preventDefault();

    if (editIndex !== null) {

      // Backend API'sine göndereceğimiz güncel veri
      const updatePayload = {
        product_katalog_name: categories.find(c => c.value === product.category)?.label || '',
        farmer_price: parseFloat(product.price),
        product_name: product.name,
        stock_quantity: parseInt(product.stock),
        // image şimdilik hariç
      };

      // Güncellenecek ürünün ID'si. Bu bilgi şu anda `products` state'inde yok.
      // TODO: Ürünleri backend'den çekerken product_id'yi de kaydetmeliyiz.
      // Şimdilik placeholder kullanalım.
      const productId = products[editIndex].id; // Ürün objesinde id olduğunu varsayalım

      try {
        // Backend API endpoint'ini çağır
        // TODO: Backend API URL'ini buraya ekleyin veya env dosyasından alın
        // TODO: Kimlik doğrulama token'ını ekleyin
        const response = await fetch(`YOUR_BACKEND_API_URL/product/${productId}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer YOUR_AUTH_TOKEN`,
          },
          body: JSON.stringify(updatePayload),
        });

        if (!response.ok) {
          const errorData = await response.json();
          throw new Error(errorData.message || 'Ürün güncellenirken bir hata oluştu.');
        }

        const updatedProduct = await response.json();
        console.log('Ürün başarıyla güncellendi:', updatedProduct);

        // Ürün başarıyla güncellendiyse listeyi yenile
        // TODO: Ürün listesini backend'den tekrar çekmek daha iyi olur
        // Şimdilik güncellenen ürünü listede bulup değiştirelim
        const updatedProducts = [...products];
        // Burada updatedProducts[editIndex] = updatedProduct; gibi bir atama yapabiliriz
        // Ancak backend'den gelen updatedProduct objesinin yapısı frontend'deki product objesi ile aynı olmalı
        // Şimdilik sadece frontend state'ini güncelleyelim.
        updatedProducts[editIndex] = {
          name: updatedProduct.product_name || updatedProducts[editIndex].name,
          category: updatedProduct.product_katalog_name || updatedProducts[editIndex].category,
          price: updatedProduct.farmer_price || updatedProducts[editIndex].price,
          stock: updatedProduct.stock_quantity || updatedProducts[editIndex].stock,
      };
      setProducts(updatedProducts);

        // Formu temizle ve düzenleme modundan çık
      setProduct({ name: '', category: '', description: '', price: '', stock: '', image: '', imagePreview: '' });
      setEditMode(false);
      setEditIndex(null);

        alert('Ürün başarıyla güncellendi!');

      } catch (error: any) {
        console.error('Ürün güncelleme hatası:', error.message);
        alert(`Ürün güncellenirken hata oluştu: ${error.message}`);
      }
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
    // Silinecek ürünün ID'si. Bu bilgi şu anda `products` state'inde yok.
    // TODO: Ürünleri backend'den çekerken product_id'yi de kaydetmeliyiz.
    // Şimdilik placeholder kullanalım.
    const productId = products[idx].id; // Ürün objesinde id olduğunu varsayalım

    try {
      // Backend API endpoint'ini çağır
      // TODO: Backend API URL'ini buraya ekleyin veya env dosyasından alın
      // TODO: Kimlik doğrulama token'ını ekleyin
      const response = await fetch(`YOUR_BACKEND_API_URL/product/${productId}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer YOUR_AUTH_TOKEN`,
        },
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.message || 'Ürün silinirken bir hata oluştu.');
      }

      console.log('Ürün başarıyla silindi:');

      // Ürün başarıyla silindiyse listeyi güncelle
      // TODO: Ürün listesini backend'den tekrar çekmek daha iyi olur
      // Şimdilik sadece frontend state'ini güncelle
    setProducts(products.filter((_, i) => i !== idx));

      alert('Ürün başarıyla silindi!');

    } catch (error: any) {
      console.error('Ürün silme hatası:', error.message);
      alert(`Ürün silinirken hata oluştu: ${error.message}`);
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
              {product.imagePreview && (
                <img src={product.imagePreview} alt="preview" style={{ width: 82, height: 82, objectFit: 'cover', borderRadius: 12 }} />
              )}
              <button type="submit" style={greenBtn}>{editMode ? 'Ürünü Güncelle' : 'Ürünü Mağazana Yükle'}</button>
            </form>
            {/* Crop Modal */}
            {cropModal && (
              <div style={{ position: 'fixed', top:0, left:0, width:'100vw', height:'100vh', background:'#0008', zIndex:1000, display:'flex', alignItems:'center', justifyContent:'center' }}>
                <div style={{ background:'#fff', padding:32, borderRadius:16, boxShadow:'0 2px 16px #0003', position:'relative' }}>
                  <h3>Fotoğrafı Kırp</h3>
                  <div style={{ position:'relative', width:300, height:300, background:'#eee', marginBottom:16 }}>
                    <Cropper
                      image={cropImg}
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
                    <button onClick={()=>setCropModal(false)} style={{...greenBtn, background:'#ccc', color:'#222'}}>İptal</button>
                    <button onClick={handleCropSave} style={greenBtn}>Kırp ve Yükle</button>
                  </div>
                </div>
              </div>
            )}
            {/* Ürün Tablosu */}
            <table style={{ width: '100%', marginTop: 40, background: '#fff', borderRadius: 12, boxShadow: '0 2px 12px #0001', borderCollapse: 'collapse' }}>
              <thead>
                <tr style={{ background: '#F5F2EA', color: '#A18249', fontWeight: 700 }}>
                  <th style={thTd}>Ürün Adı</th>
                  <th style={thTd}>Kategori</th>
                  <th style={thTd}>Fiyat</th>
                  <th style={thTd}>Stok Miktarı</th>
                  <th style={thTd}>İşlemler</th>
                </tr>
              </thead>
              <tbody>
                {products.map((p, i) => (
                  <tr key={i} style={{ textAlign: 'center', borderBottom: '1px solid #E9DFCE' }}>
                    <td style={thTd}>{p.name}</td>
                    <td style={thTd}>{p.category}</td>
                    <td style={thTd}>₺{p.price.toFixed(2)}</td>
                    <td style={thTd}>{p.stock}</td>
                    <td style={thTd}>
                      <button style={editBtn} onClick={() => handleEdit(i)}>Düzenle</button>
                      <button style={deleteBtn} onClick={()=>handleDelete(i)}>Sil</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </section>
        ) : (
          <section style={{ maxWidth: 600 }}>
            <h2 style={{ fontWeight: 700, fontSize: 24, marginBottom: 16 }}>Farm Information</h2>
            <label>Introduction
              <textarea className="form-input" style={{...inputStyle, minHeight:60}} value={farmInfo.intro} onChange={e=>setFarmInfo({...farmInfo, intro:e.target.value})} />
            </label>
            <label>Farm Image
              <input type="file" accept="image/*" onChange={handleFarmImage} />
            </label>
            {farmInfo.imagePreview && <img src={farmInfo.imagePreview} alt="farm" style={{ width: '100%', maxHeight: 260, objectFit: 'cover', borderRadius: 12, marginBottom: 16 }} />}
            <label>Upload Certification
              <input type="file" accept="application/pdf,image/*" onChange={handleCert} />
            </label>
            <button style={greenBtn}>Save Farm Information</button>
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
const navLink = {
  color: '#A18249',
  fontWeight: 600,
  textDecoration: 'none',
  fontSize: 17,
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

     .dashboard-main-content table {
        width: 100%;
        display: block;
        overflow-x: auto;
        white-space: nowrap;
    }

     .dashboard-main-content thead,
     .dashboard-main-content tbody,
     .dashboard-main-content th,
     .dashboard-main-content td,
     .dashboard-main-content tr {
        display: block;
    }

     .dashboard-main-content tr {
        position:top;
        border: 1px solid #E9DFCE;
        margin-bottom: 16px;
        padding: 12px;
        border-radius: 8px;
     }

     .dashboard-main-content td {
        border: none;
        position: relative;
        padding-left: 130px;
        margin-bottom: 8px;
        word-wrap: break-word;
        white-space: normal;
     }

     .dashboard-main-content td::before {
        content: attr(data-label);
        font-weight: bold;
        display: inline-block;
        position: absolute;
        left: 12px;
        width: 110px;
        margin-right: 16px;
     }

    .dashboard-main-content th {
        display: none;
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

     .dashboard-main-content td::before {
        width: 90px;
     }
     
     /* Genel olarak ana içerikteki öğelerin taşmasını engelle (telefon) */
    .dashboard-main-content * {
        box-sizing: border-box;
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
