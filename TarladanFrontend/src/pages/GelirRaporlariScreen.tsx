import React, { useState, useEffect, useCallback } from 'react';

interface IncomeRecord {
  id: string;
  order_prduct_id: string;
  product_id: string;
  farmer_id: string;
  farmer_name: string;
  product_name: string;
  product_quantity: number;
  product_income: number;
  created_at?: string;
}

interface ProductSummary {
  product_name: string;
  total_quantity: number;
  total_income: number;
  order_count: number;
}

interface IncomeReportsData {
  income_records: IncomeRecord[];
  total_income: number;
  product_summary: ProductSummary[];
  record_count: number;
}

interface GelirRaporlariScreenProps {
  isMobile: boolean;
}

const GelirRaporlariScreen: React.FC<GelirRaporlariScreenProps> = ({ isMobile }) => {
  const [incomeData, setIncomeData] = useState<IncomeReportsData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [selectedTab, setSelectedTab] = useState<'all' | 'summary'>('all');
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');
  const [refreshNotification, setRefreshNotification] = useState<string | null>(null);

  // Gelir raporlarını yükle
  const loadIncomeReports = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      // localStorage'daki tüm verileri debug için kontrol et
      console.log('=== localStorage Debug ===');
      console.log('localStorage keys:', Object.keys(localStorage));
      
      for (let i = 0; i < localStorage.length; i++) {
        const key = localStorage.key(i);
        if (key) {
          const value = localStorage.getItem(key);
          console.log(`${key}:`, value);
          
          // JSON formatında mı kontrol et
          if (value && (value.startsWith('{') || value.startsWith('['))) {
            try {
              const parsed = JSON.parse(value);
              console.log(`${key} (parsed):`, parsed);
            } catch (e) {
              console.log(`${key} JSON parse hatası:`, e);
            }
          }
        }
      }

      // localStorage'dan user bilgilerini al
      const userData = localStorage.getItem('user');
      if (!userData) {
        console.error('user verisi localStorage\'da bulunamadı');
        throw new Error('Kullanıcı bilgileri bulunamadı. Lütfen tekrar giriş yapın.');
      }

      const user = JSON.parse(userData);
      console.log('Giriş yapmış kullanıcı:', user);
      
      // Farmer ID'yi user objesinden al - farklı olasılıkları dene
      let farmerId = user.farmer_id || user.id || user.farmerId;
      
      // Nested objeler kontrol et
      if (!farmerId && user.farmer) {
        farmerId = user.farmer.farmer_id || user.farmer.id;
      }
      
      // Eğer user objesi auth user ise
      if (!farmerId && user.user_metadata) {
        farmerId = user.user_metadata.farmer_id;
      }
      
      if (!farmerId) {
        console.error('Farmer ID bulunamadı. User objesi:', user);
        console.error('User objesi keys:', Object.keys(user));
        throw new Error('Farmer ID bulunamadı. Lütfen tekrar giriş yapın.');
      }

      console.log('Giriş yapmış farmer ID:', farmerId);

      // Test endpoint kullanıyoruz
      let url = `http://localhost:3001/farmer/income-reports/test/${farmerId}`;
      
      const params = new URLSearchParams();
      if (startDate) params.append('startDate', startDate);
      if (endDate) params.append('endDate', endDate);
      
      if (params.toString()) {
        url += `?${params.toString()}`;
      }

      console.log('Gelir raporları URL:', url);

      const response = await fetch(url);
      if (!response.ok) {
        const errorText = await response.text();
        console.error('API Hatası:', errorText);
        throw new Error(`Gelir raporları yüklenirken hata oluştu (${response.status})`);
      }

      const data = await response.json();
      console.log('Gelir raporları verisi:', data);
      setIncomeData(data);
    } catch (err: any) {
      console.error('Gelir raporları yükleme hatası:', err);
      setError(err.message || 'Veriler yüklenirken hata oluştu');
    } finally {
      setLoading(false);
    }
  }, [startDate, endDate]);

  useEffect(() => {
    loadIncomeReports();
  }, [loadIncomeReports]);

  useEffect(() => {
    // Sipariş hazırlandığında gelir raporlarını otomatik yenile
    const handleIncomeUpdate = (event: any) => {
      console.log('💰 Gelir güncellemesi algılandı:', event.detail);
      
      // Bildirim göster
      setRefreshNotification('🔄 Yeni gelir kaydı eklendi, raporlar yenileniyor...');
      
      // Kısa bir gecikmeyle yenile (backend işleminin tamamlanması için)
      setTimeout(() => {
        console.log('🔄 Gelir raporları otomatik yenileniyor...');
        
        // Güvenli yenileme - hata olursa sadece bildirimi göster
        loadIncomeReports()
          .then(() => {
            // Başarı bildirimi göster
            setTimeout(() => {
              setRefreshNotification('✅ Gelir raporları güncellendi!');
              
              // 3 saniye sonra bildirimi gizle
              setTimeout(() => {
                setRefreshNotification(null);
              }, 3000);
            }, 500);
          })
          .catch((error) => {
            console.error('Otomatik yenileme hatası:', error);
            setRefreshNotification('⚠️ Gelir raporları yenilenemedi. Sayfayı manuel yenileyin.');
            
            // 5 saniye sonra bildirimi gizle
            setTimeout(() => {
              setRefreshNotification(null);
            }, 5000);
          });
      }, 1000);
    };

    // Event listener ekle
    window.addEventListener('incomeUpdated', handleIncomeUpdate);

    // Cleanup function
    return () => {
      window.removeEventListener('incomeUpdated', handleIncomeUpdate);
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []); // loadIncomeReports dependency'sini kaldırdık çünkü sadece mount'ta çalışması gerekiyor

  const handleDateFilter = () => {
    loadIncomeReports();
  };

  const formatDate = (dateString?: string) => {
    if (!dateString) return 'Bilinmiyor';
    return new Date(dateString).toLocaleDateString('tr-TR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('tr-TR', {
      style: 'currency',
      currency: 'TRY'
    }).format(amount);
  };

  if (loading) {
    return (
      <div style={{ 
        display: 'flex', 
        justifyContent: 'center', 
        alignItems: 'center', 
        minHeight: '400px',
        fontSize: '16px',
        color: '#666'
      }}>
        Gelir raporları yükleniyor...
      </div>
    );
  }

  if (error) {
    return (
      <div style={{ 
        textAlign: 'center', 
        padding: '32px',
        color: '#e74c3c'
      }}>
        <h3>Hata Oluştu</h3>
        <p>{error}</p>
        <button 
          onClick={loadIncomeReports}
          style={{
            padding: '8px 16px',
            backgroundColor: '#3498db',
            color: 'white',
            border: 'none',
            borderRadius: '4px',
            cursor: 'pointer',
            marginTop: '16px'
          }}
        >
          Tekrar Dene
        </button>
      </div>
    );
  }

  return (
    <div style={{ maxWidth: isMobile ? '100%' : '1200px', margin: '0 auto', padding: isMobile ? '16px' : '24px' }}>
      <h2 style={{ 
        fontWeight: 700, 
        fontSize: isMobile ? '20px' : '24px', 
        marginBottom: '24px',
        color: '#2c3e50'
      }}>
        💰 Gelir Raporları
      </h2>

      {/* Otomatik Yenilenme Bildirimi */}
      {refreshNotification && (
        <div style={{
          backgroundColor: refreshNotification.includes('✅') ? '#d1fae5' : '#dbeafe',
          border: `1px solid ${refreshNotification.includes('✅') ? '#10b981' : '#3b82f6'}`,
          color: refreshNotification.includes('✅') ? '#065f46' : '#1e40af',
          padding: '12px 16px',
          borderRadius: '8px',
          marginBottom: '16px',
          fontSize: '14px',
          fontWeight: '500',
          textAlign: 'center'
        }}>
          {refreshNotification}
        </div>
      )}

      {/* Tarih Filtresi */}
      <div style={{ 
        backgroundColor: '#f8f9fa',
        padding: '16px',
        borderRadius: '8px',
        marginBottom: '24px',
        display: 'flex',
        flexDirection: isMobile ? 'column' : 'row',
        gap: '16px',
        alignItems: isMobile ? 'stretch' : 'center'
      }}>
        <div style={{ display: 'flex', gap: '16px', flex: 1, flexDirection: isMobile ? 'column' : 'row' }}>
          <div style={{ flex: 1 }}>
            <label style={{ display: 'block', marginBottom: '4px', fontSize: '14px', fontWeight: 600 }}>
              Başlangıç Tarihi
            </label>
            <input
              type="date"
              value={startDate}
              onChange={(e) => setStartDate(e.target.value)}
              style={{
                padding: '8px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                width: '100%'
              }}
            />
          </div>
          <div style={{ flex: 1 }}>
            <label style={{ display: 'block', marginBottom: '4px', fontSize: '14px', fontWeight: 600 }}>
              Bitiş Tarihi
            </label>
            <input
              type="date"
              value={endDate}
              onChange={(e) => setEndDate(e.target.value)}
              style={{
                padding: '8px',
                border: '1px solid #ddd',
                borderRadius: '4px',
                width: '100%'
              }}
            />
          </div>
        </div>
        <button
          onClick={handleDateFilter}
          style={{
            padding: '8px 16px',
            backgroundColor: '#27ae60',
            color: 'white',
            border: 'none',
            borderRadius: '4px',
            cursor: 'pointer',
            fontWeight: 600,
            alignSelf: isMobile ? 'stretch' : 'flex-end'
          }}
        >
          Filtrele
        </button>
      </div>

      {/* Özet Kartları */}
      {incomeData && (
        <div style={{ 
          display: 'grid', 
          gridTemplateColumns: isMobile ? '1fr' : 'repeat(auto-fit, minmax(200px, 1fr))',
          gap: '16px',
          marginBottom: '24px'
        }}>
          <div style={{
            backgroundColor: '#e8f5e8',
            padding: '16px',
            borderRadius: '8px',
            textAlign: 'center'
          }}>
            <h4 style={{ margin: '0 0 8px 0', color: '#27ae60' }}>Toplam Gelir</h4>
            <p style={{ margin: 0, fontSize: '20px', fontWeight: 700, color: '#27ae60' }}>
              {formatCurrency(incomeData.total_income)}
            </p>
          </div>
          <div style={{
            backgroundColor: '#e3f2fd',
            padding: '16px',
            borderRadius: '8px',
            textAlign: 'center'
          }}>
            <h4 style={{ margin: '0 0 8px 0', color: '#2196f3' }}>Satış Sayısı</h4>
            <p style={{ margin: 0, fontSize: '20px', fontWeight: 700, color: '#2196f3' }}>
              {incomeData.record_count}
            </p>
          </div>
          <div style={{
            backgroundColor: '#fff3e0',
            padding: '16px',
            borderRadius: '8px',
            textAlign: 'center'
          }}>
            <h4 style={{ margin: '0 0 8px 0', color: '#ff9800' }}>Ürün Çeşidi</h4>
            <p style={{ margin: 0, fontSize: '20px', fontWeight: 700, color: '#ff9800' }}>
              {incomeData.product_summary.length}
            </p>
          </div>
        </div>
      )}

      {/* Tab Menüsü */}
      <div style={{ 
        borderBottom: '2px solid #eee',
        marginBottom: '24px',
        display: 'flex'
      }}>
        <button
          onClick={() => setSelectedTab('all')}
          style={{
            padding: '12px 24px',
            border: 'none',
            backgroundColor: 'transparent',
            borderBottom: selectedTab === 'all' ? '2px solid #3498db' : '2px solid transparent',
            color: selectedTab === 'all' ? '#3498db' : '#666',
            cursor: 'pointer',
            fontWeight: 600
          }}
        >
          Tüm Satışlar
        </button>
        <button
          onClick={() => setSelectedTab('summary')}
          style={{
            padding: '12px 24px',
            border: 'none',
            backgroundColor: 'transparent',
            borderBottom: selectedTab === 'summary' ? '2px solid #3498db' : '2px solid transparent',
            color: selectedTab === 'summary' ? '#3498db' : '#666',
            cursor: 'pointer',
            fontWeight: 600
          }}
        >
          Ürün Özeti
        </button>
      </div>

      {/* İçerik */}
      {incomeData && (
        <>
          {selectedTab === 'all' ? (
            <div>
              {incomeData.income_records.length === 0 ? (
                <div style={{ 
                  textAlign: 'center', 
                  padding: '32px',
                  color: '#999',
                  backgroundColor: '#f8f9fa',
                  borderRadius: '8px'
                }}>
                  Henüz gelir kaydı bulunamadı.
                </div>
              ) : (
                <div style={{ 
                  display: 'grid', 
                  gap: '16px'
                }}>
                  {incomeData.income_records.map((record) => (
                    <div
                      key={record.id}
                      style={{
                        backgroundColor: 'white',
                        border: '1px solid #eee',
                        borderRadius: '8px',
                        padding: '16px',
                        boxShadow: '0 2px 4px rgba(0,0,0,0.1)'
                      }}
                    >
                      <div style={{ 
                        display: 'flex', 
                        justifyContent: 'space-between',
                        alignItems: isMobile ? 'flex-start' : 'center',
                        flexDirection: isMobile ? 'column' : 'row',
                        gap: isMobile ? '8px' : '16px'
                      }}>
                        <div style={{ flex: 1 }}>
                          <h4 style={{ margin: '0 0 8px 0', color: '#2c3e50' }}>
                            {record.product_name}
                          </h4>
                          <p style={{ margin: '0 0 4px 0', fontSize: '14px', color: '#666' }}>
                            <strong>Miktar:</strong> {record.product_quantity} adet
                          </p>
                          <p style={{ margin: '0 0 4px 0', fontSize: '14px', color: '#666' }}>
                            <strong>Sipariş ID:</strong> {record.order_prduct_id}
                          </p>
                          <p style={{ margin: '0', fontSize: '14px', color: '#666' }}>
                            <strong>Tarih:</strong> {formatDate(record.created_at)}
                          </p>
                        </div>
                        <div style={{ 
                          textAlign: isMobile ? 'left' : 'right',
                          minWidth: isMobile ? 'auto' : '120px'
                        }}>
                          <p style={{ 
                            margin: 0, 
                            fontSize: '18px', 
                            fontWeight: 700, 
                            color: '#27ae60' 
                          }}>
                            {formatCurrency(record.product_income)}
                          </p>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </div>
          ) : (
            <div>
              {incomeData.product_summary.length === 0 ? (
                <div style={{ 
                  textAlign: 'center', 
                  padding: '32px',
                  color: '#999',
                  backgroundColor: '#f8f9fa',
                  borderRadius: '8px'
                }}>
                  Ürün özeti bulunamadı.
                </div>
              ) : (
                <div style={{ 
                  display: 'grid', 
                  gap: '16px'
                }}>
                  {incomeData.product_summary.map((summary, index) => (
                    <div
                      key={index}
                      style={{
                        backgroundColor: 'white',
                        border: '1px solid #eee',
                        borderRadius: '8px',
                        padding: '16px',
                        boxShadow: '0 2px 4px rgba(0,0,0,0.1)'
                      }}
                    >
                      <div style={{ 
                        display: 'flex', 
                        justifyContent: 'space-between',
                        alignItems: isMobile ? 'flex-start' : 'center',
                        flexDirection: isMobile ? 'column' : 'row',
                        gap: isMobile ? '8px' : '16px'
                      }}>
                        <div style={{ flex: 1 }}>
                          <h4 style={{ margin: '0 0 8px 0', color: '#2c3e50' }}>
                            {summary.product_name}
                          </h4>
                          <p style={{ margin: '0 0 4px 0', fontSize: '14px', color: '#666' }}>
                            <strong>Toplam Satış:</strong> {summary.total_quantity} adet
                          </p>
                          <p style={{ margin: '0', fontSize: '14px', color: '#666' }}>
                            <strong>Sipariş Sayısı:</strong> {summary.order_count}
                          </p>
                        </div>
                        <div style={{ 
                          textAlign: isMobile ? 'left' : 'right',
                          minWidth: isMobile ? 'auto' : '120px'
                        }}>
                          <p style={{ 
                            margin: 0, 
                            fontSize: '18px', 
                            fontWeight: 700, 
                            color: '#27ae60' 
                          }}>
                            {formatCurrency(summary.total_income)}
                          </p>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}
        </>
      )}
    </div>
  );
};

export default GelirRaporlariScreen; 