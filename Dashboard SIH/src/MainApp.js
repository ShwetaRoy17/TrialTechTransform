import React from 'react'
import Login from './pages/Login'
import App from './App'
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import {
    Home,
    Orders,
    Calendar,
    Lawyers,
    UTPCases,
    Kanban,
  } from './pages';
const MainApp = () => {

  return (
    <div>
        <BrowserRouter>
        {/* <Login /> */}
        <Routes>
                {/* Login */}
                <Route path="/login" element={<Login />} />

                {/* dashboard  */}
                <Route path="/" element={<Login />} />
                <Route path="/home" element={<Home />} />

                {/* pages  */}
                <Route path="/orders" element={<Orders />} />
                <Route path="/lawyers" element={<Lawyers />} />
                <Route path="/UTP%20Cases" element={<UTPCases />} />
                <Route path="/bail%20granted%20Cases" element={<BailGrantedCases />} />
                <Route path="/solved%20Cases" element={<SolvedCases />} />
                <Route path="/state%20wise%20Cases" element={<StateWiseCases />} />
                <Route path="/recent%20Cases" element={<RecentCases />} />

                {/* apps  */}
                <Route path="/To-do%20List" element={<Kanban />} />
                <Route path="/calendar" element={<Calendar />} />
              </Routes>
        </BrowserRouter>
    </div>
  )
}

export default MainApp