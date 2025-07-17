import React from 'react';
import { render } from '@testing-library/react';

// Basit test componenti
const SimpleComponent = () => {
  return <div>Test Component</div>;
};

describe('Basit Testler', () => {
  test('component render edilir', () => {
    const { getByText } = render(<SimpleComponent />);
    expect(getByText('Test Component')).toBeInTheDocument();
  });

  test('matematik işlemleri çalışır', () => {
    expect(2 + 2).toBe(4);
    expect(5 * 3).toBe(15);
  });

  test('string işlemleri çalışır', () => {
    const text = 'Tarladan Frontend';
    expect(text).toContain('Frontend');
    expect(text.length).toBeGreaterThan(0);
  });

  test('array işlemleri çalışır', () => {
    const fruits = ['elma', 'armut', 'kiraz'];
    expect(fruits).toHaveLength(3);
    expect(fruits).toContain('elma');
  });

  test('object kontrolü çalışır', () => {
    const farmer = {
      name: 'Test Çiftçi',
      products: ['domates', 'salatalık']
    };
    
    expect(farmer.name).toBe('Test Çiftçi');
    expect(farmer.products).toHaveLength(2);
  });
}); 