import React from 'react';
import ReactDOM from 'react-dom';

import './index.css';
import App from './App';
import MainApp from './MainApp';
import { UserProvider, ContextProvider } from './contexts/ContextProvider';

ReactDOM.render(
  <React.StrictMode>
    <UserProvider>
      <ContextProvider>
        <App />
      </ContextProvider>
    </UserProvider>
  </React.StrictMode>,
  document.getElementById('root'),
);
