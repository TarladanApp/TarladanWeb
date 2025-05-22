import React, { useState, useCallback } from 'react';
import Cropper from 'react-easy-crop';
const categories = [
  { value: '', label: 'Select' },
  { value: 'vegetable', label: 'Vegetable' },
  { value: 'fruit', label: 'Fruit' },
  { value: 'grain', label: 'Grain' },
];

const initialProducts = [
  { name: 'Tomatoes', category: 'Vegetable', price: 2.0, stock: 100 },
  { name: 'Carrots', category: 'Vegetable', price: 1.5, stock: 200 },
  { name: 'Apples', category: 'Fruit', price: 3.0, stock: 50 },
];

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
  const [farmInfo, setFarmInfo] = useState({
    intro: '',
    image: '',
    imagePreview: '',
    cert: '',
  });
  const [tab, setTab] = useState<'product' | 'farm'>('product');
  const [cropModal, setCropModal] = useState(false);
  const [cropImg, setCropImg] = useState('');
  const [crop, setCrop] = useState({ x: 0, y: 0 });
  const [zoom, setZoom] = useState(1);
  const [croppedAreaPixels, setCroppedAreaPixels] = useState<any>(null);
  const [editMode, setEditMode] = useState(false);
  const [editIndex, setEditIndex] = useState<number | null>(null);

  // Ürün görseli yükleme (crop ile)
  const handleProductImage = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
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
      const cropped = await getCroppedImg(cropImg, croppedAreaPixels, zoom, 1, 82);
      setProduct({ ...product, image: cropped, imagePreview: cropped });
      setCropModal(false);
      setCropImg('');
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

  // Ürün ekleme
  const handleAddProduct = (e: React.FormEvent) => {
    e.preventDefault();
    setProducts([
      ...products,
      {
        name: product.name,
        category: categories.find(c => c.value === product.category)?.label || '',
        price: parseFloat(product.price),
        stock: parseInt(product.stock),
      },
    ]);
    setProduct({ name: '', category: '', description: '', price: '', stock: '', image: '', imagePreview: '' });
  };

  // Ürün güncelleme
  const handleUpdateProduct = (e: React.FormEvent) => {
    e.preventDefault();
    if (editIndex !== null) {
      const updatedProducts = [...products];
      updatedProducts[editIndex] = {
        name: product.name,
        category: categories.find(c => c.value === product.category)?.label || '',
        price: parseFloat(product.price),
        stock: parseInt(product.stock),
      };
      setProducts(updatedProducts);
      setProduct({ name: '', category: '', description: '', price: '', stock: '', image: '', imagePreview: '' });
      setEditMode(false);
      setEditIndex(null);
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
  const handleDelete = (idx: number) => {
    setProducts(products.filter((_, i) => i !== idx));
  };

  return (
    <div style={{ display: 'flex', minHeight: '100vh', background: '#FAF8F3' }}>
      {/* Sol Menü */}
      <aside style={{ width: 220, background: '#F5F2EA', padding: 24, display: 'flex', flexDirection: 'column', gap: 16 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 32 }}>
          <img src={require('../assets/brand-logo.png')} alt="logo" style={{ width: 40, borderRadius: '50%' }} />
          <div>
            <div style={{ fontWeight: 700, fontSize: 16 }}>Hoş Geldin</div>
            <div style={{ fontSize: 13, color: '#A18249' }}>Hasan Gürbüz</div>
          </div>
        </div>
        <button style={tab==='product'?menuActive:menuBtn} onClick={()=>setTab('product')}>Panelim</button>
        <button style={tab==='farm'?menuActive:menuBtn} onClick={()=>setTab('farm')}>Çiftliğim</button>
      </aside>
      {/* Ana İçerik */}
      <main style={{ flex: 1, padding: '32px 48px' }}>
        {/* Üst Menü */}
        <nav style={{ display: 'flex', justifyContent: 'flex-end', alignItems: 'center', gap: 32, marginBottom: 24 }}>
          <button style={logoutBtn}>Logout</button>
        </nav>
        <h1 style={{ fontSize: 36, fontWeight: 800, marginBottom: 4 }}>Satış Panelim</h1>
        <div style={{ color: '#A18249', marginBottom: 24 }}>Ürünlerinizi ve Çiftliğinizi Yönetin</div>
        {/* Tab menü */}
        <div style={{ display: 'flex', gap: 32, borderBottom: '1px solid #E9DFCE', marginBottom: 32 }}>
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
