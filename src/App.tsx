import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Register from './pages/register';
import MainPage from './pages/main';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<MainPage />} />
        <Route path="/register" element={<Register />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;