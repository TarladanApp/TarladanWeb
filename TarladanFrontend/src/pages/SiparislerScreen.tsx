import React, { useState, useEffect } from 'react';
import { getFarmerOrders, updateOrderStatus } from '../services/api';

interface OrderProduct {
  order_id: string;
  order_product_id: string;
  farmer_id: string;
  farmer_name: string;
  unit_quantity: number;
  unit_price: number;
  total_product_price: number;
  order_product_rate?: number;
  delivery_address_id: string;
  product_name: string;
  product_id: string;
  order_product_status?: string;
  product_image_url?: string;
  product_description?: string;
}

interface SiparislerScreenProps {
  isMobile: boolean;
}

export default function SiparislerScreen({ isMobile }: SiparislerScreenProps) {
  const [orders, setOrders] = useState<OrderProduct[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [updatingOrder, setUpdatingOrder] = useState<string | null>(null);

  useEffect(() => {
    loadOrders();
  }, []);

  const loadOrders = async () => {
    try {
      console.log('SiparislerScreen - loadOrders başlıyor...');
      setLoading(true);
      setError('');
      
      const response = await getFarmerOrders();
      console.log('SiparislerScreen - API response:', response);
      
      if (response.success) {
        console.log('SiparislerScreen - Orders data:', response.data);
        console.log('SiparislerScreen - Orders count:', response.data.length);
        setOrders(response.data);
      } else {
        console.error('SiparislerScreen - API success false:', response);
        setError('Siparişler yüklenemedi');
      }
    } catch (err: any) {
      console.error('SiparislerScreen - Sipariş yükleme hatası:', err);
      console.error('SiparislerScreen - Error details:', {
        message: err.message,
        response: err.response?.data,
        status: err.response?.status
      });
      setError(err.response?.data?.message || 'Siparişler yüklenirken hata oluştu');
    } finally {
      setLoading(false);
      console.log('SiparislerScreen - loadOrders tamamlandı');
    }
  };

  const handleStatusUpdate = async (orderProductId: string, status: string) => {
    try {
      setUpdatingOrder(orderProductId);
      const response = await updateOrderStatus(orderProductId, status);
      
      if (response.success) {
        // Listeyi güncelle
        setOrders(prevOrders =>
          prevOrders.map(order =>
            order.order_product_id === orderProductId
              ? { ...order, order_product_status: status }
              : order
          )
        );

        // Sipariş "hazırlandı" durumuna geçtiğinde gelir raporlarını bilgilendir
        if (status === 'hazırlandı') {
          console.log('✅ Sipariş hazırlandı! Gelir aktarımı yapıldı:', orderProductId);
          
          // Başarı bildirimi göster
          alert('✅ Sipariş hazırlandı ve gelir kaydınıza eklendi!');
          
          // Custom event ile gelir raporları sayfasına bilgi gönder (güvenli)
          try {
            const incomeUpdateEvent = new CustomEvent('incomeUpdated', {
              detail: {
                orderProductId,
                message: 'Yeni gelir kaydı eklendi'
              }
            });
            window.dispatchEvent(incomeUpdateEvent);
          } catch (eventError) {
            console.log('Event gönderme hatası (normal):', eventError);
          }
        }
      }
    } catch (err: any) {
      console.error('Durum güncelleme hatası:', err);
      alert(err.response?.data?.message || 'Durum güncellenirken hata oluştu');
    } finally {
      setUpdatingOrder(null);
    }
  };

  const getStatusColor = (status?: string) => {
    switch (status) {
      case 'onaylandı':
        return '#10B981'; // green
      case 'iptal edildi':
        return '#EF4444'; // red
      case 'hazırlandı':
        return '#3B82F6'; // blue
      default:
        return '#F59E0B'; // orange
    }
  };

  const getStatusText = (status?: string) => {
    switch (status) {
      case 'onaylandı':
        return 'Onaylandı';
      case 'iptal edildi':
        return 'İptal Edildi';
      case 'hazırlandı':
        return 'Hazırlandı';
      default:
        return 'Bekliyor';
    }
  };

  const renderStatusButtons = (order: OrderProduct) => {
    const { order_product_status, order_product_id } = order;
    const isUpdating = updatingOrder === order_product_id;

    if (order_product_status === 'iptal edildi') {
      return (
        <div style={{
          padding: '8px 16px',
          background: '#FEE2E2',
          color: '#DC2626',
          borderRadius: '8px',
          fontSize: '14px',
          fontWeight: '500',
        }}>
          İptal Edildi
        </div>
      );
    }

    if (order_product_status === 'hazırlandı') {
      return (
        <div style={{
          padding: '8px 16px',
          background: '#DBEAFE',
          color: '#1D4ED8',
          borderRadius: '8px',
          fontSize: '14px',
          fontWeight: '500',
        }}>
          Hazırlandı
        </div>
      );
    }

    if (order_product_status === 'onaylandı') {
      return (
        <button
          onClick={() => handleStatusUpdate(order_product_id, 'hazırlandı')}
          disabled={isUpdating}
          style={{
            padding: '8px 16px',
            background: '#3B82F6',
            color: 'white',
            border: 'none',
            borderRadius: '8px',
            fontSize: '14px',
            fontWeight: '500',
            cursor: isUpdating ? 'not-allowed' : 'pointer',
            opacity: isUpdating ? 0.7 : 1,
          }}
        >
          {isUpdating ? 'Güncelleniyor...' : 'Sipariş Hazırlandı'}
        </button>
      );
    }

    // Yeni sipariş - onay/iptal butonları
    return (
      <div style={{
        display: 'flex',
        gap: '8px',
        flexWrap: 'wrap',
      }}>
        <button
          onClick={() => handleStatusUpdate(order_product_id, 'onaylandı')}
          disabled={isUpdating}
          style={{
            padding: '8px 16px',
            background: '#10B981',
            color: 'white',
            border: 'none',
            borderRadius: '8px',
            fontSize: '14px',
            fontWeight: '500',
            cursor: isUpdating ? 'not-allowed' : 'pointer',
            opacity: isUpdating ? 0.7 : 1,
          }}
        >
          {isUpdating ? 'Güncelleniyor...' : '✅ Siparişi Onayla'}
        </button>
        <button
          onClick={() => handleStatusUpdate(order_product_id, 'iptal edildi')}
          disabled={isUpdating}
          style={{
            padding: '8px 16px',
            background: '#EF4444',
            color: 'white',
            border: 'none',
            borderRadius: '8px',
            fontSize: '14px',
            fontWeight: '500',
            cursor: isUpdating ? 'not-allowed' : 'pointer',
            opacity: isUpdating ? 0.7 : 1,
          }}
        >
          {isUpdating ? 'Güncelleniyor...' : '❌ Siparişi İptal Et'}
        </button>
      </div>
    );
  };

  if (loading) {
    return (
      <div style={{
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        height: '400px',
        fontSize: '18px',
        color: '#6B7280',
      }}>
        Siparişler yükleniyor...
      </div>
    );
  }

  if (error) {
    return (
      <div style={{
        display: 'flex',
        flexDirection: 'column',
        justifyContent: 'center',
        alignItems: 'center',
        height: '400px',
        gap: '16px',
      }}>
        <div style={{
          fontSize: '18px',
          color: '#EF4444',
          textAlign: 'center',
        }}>
          {error}
        </div>
        <button
          onClick={loadOrders}
          style={{
            padding: '10px 20px',
            background: '#3B82F6',
            color: 'white',
            border: 'none',
            borderRadius: '8px',
            cursor: 'pointer',
          }}
        >
          Tekrar Dene
        </button>
      </div>
    );
  }

  if (orders.length === 0) {
    return (
      <div style={{
        display: 'flex',
        flexDirection: 'column',
        justifyContent: 'center',
        alignItems: 'center',
        height: '400px',
        gap: '16px',
      }}>
        <div style={{
          fontSize: '48px',
          color: '#D1D5DB',
        }}>
          📦
        </div>
        <div style={{
          fontSize: '18px',
          color: '#6B7280',
          textAlign: 'center',
        }}>
          Henüz sipariş bulunmuyor
        </div>
        <div style={{
          fontSize: '14px',
          color: '#9CA3AF',
          textAlign: 'center',
          maxWidth: '300px',
        }}>
          Ürünlerinize gelen siparişler burada görünecek
        </div>
      </div>
    );
  }

  return (
    <div style={{
      padding: isMobile ? '16px' : '24px',
      maxWidth: '100%',
    }}>
      <div style={{
        marginBottom: '24px',
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        flexWrap: 'wrap',
        gap: '16px',
      }}>
        <h2 style={{
          fontSize: isMobile ? '20px' : '24px',
          fontWeight: '700',
          color: '#1F2937',
          margin: 0,
        }}>
          🛒 Siparişlerim ({orders.length})
        </h2>
        <button
          onClick={loadOrders}
          style={{
            padding: '8px 16px',
            background: '#F3F4F6',
            color: '#374151',
            border: '1px solid #D1D5DB',
            borderRadius: '8px',
            fontSize: '14px',
            cursor: 'pointer',
            display: 'flex',
            alignItems: 'center',
            gap: '8px',
          }}
        >
          🔄 Yenile
        </button>
      </div>

      <div style={{
        display: 'grid',
        gridTemplateColumns: isMobile ? '1fr' : 'repeat(auto-fill, minmax(400px, 1fr))',
        gap: '16px',
      }}>
        {orders.map((order) => (
          <div key={order.order_product_id} style={{
            background: 'white',
            border: '1px solid #E5E7EB',
            borderRadius: '12px',
            padding: '20px',
            boxShadow: '0 1px 3px rgba(0, 0, 0, 0.1)',
            transition: 'all 0.2s',
          }}>
            <div style={{
              display: 'flex',
              gap: '16px',
              marginBottom: '16px',
            }}>
              {order.product_image_url ? (
                <img
                  src={order.product_image_url}
                  alt={order.product_name}
                  style={{
                    width: '80px',
                    height: '80px',
                    borderRadius: '8px',
                    objectFit: 'cover',
                    border: '1px solid #E5E7EB',
                  }}
                />
              ) : (
                <div style={{
                  width: '80px',
                  height: '80px',
                  borderRadius: '8px',
                  background: '#F3F4F6',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontSize: '24px',
                  color: '#9CA3AF',
                }}>
                  📦
                </div>
              )}
              
              <div style={{ flex: 1 }}>
                <h3 style={{
                  fontSize: '18px',
                  fontWeight: '600',
                  color: '#1F2937',
                  margin: '0 0 8px 0',
                }}>
                  {order.product_name}
                </h3>
                <div style={{
                  fontSize: '14px',
                  color: '#6B7280',
                  marginBottom: '4px',
                }}>
                  Sipariş ID: #{order.order_id}
                </div>
                <div style={{
                  display: 'inline-block',
                  padding: '4px 8px',
                  background: getStatusColor(order.order_product_status),
                  color: 'white',
                  borderRadius: '6px',
                  fontSize: '12px',
                  fontWeight: '500',
                }}>
                  {getStatusText(order.order_product_status)}
                </div>
              </div>
            </div>

            <div style={{
              display: 'grid',
              gridTemplateColumns: isMobile ? '1fr' : '1fr 1fr',
              gap: '12px',
              marginBottom: '16px',
              padding: '12px',
              background: '#F9FAFB',
              borderRadius: '8px',
            }}>
              <div>
                <div style={{
                  fontSize: '12px',
                  color: '#6B7280',
                  marginBottom: '4px',
                }}>
                  Miktar
                </div>
                <div style={{
                  fontSize: '16px',
                  fontWeight: '600',
                  color: '#1F2937',
                }}>
                  {order.unit_quantity} Kilogram
                </div>
              </div>
              <div>
                <div style={{
                  fontSize: '12px',
                  color: '#6B7280',
                  marginBottom: '4px',
                }}>
                  Toplam Fiyat
                </div>
                <div style={{
                  fontSize: '16px',
                  fontWeight: '600',
                  color: '#059669',
                }}>
                  ₺{order.total_product_price}
                </div>
              </div>
            </div>

            <div>
              {renderStatusButtons(order)}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
} 