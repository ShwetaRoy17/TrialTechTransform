// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import {getAuth} from "firebase/auth";
import {onAuthStateChanged} from "firebase/auth";

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyBJ5mj42jin9RR-vywBlEBbATRjP0t7lTc",
  authDomain: "dashboard-50668.firebaseapp.com",
  projectId: "dashboard-50668",
  storageBucket: "dashboard-50668.appspot.com",
  messagingSenderId: "1081323960041",
  appId: "1:1081323960041:web:c7fdb32ecc7f4228d12278",
  measurementId: "G-7NRNJDKM7H"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);

export const onAuthStateChangedListener = (callback) => {
    return onAuthStateChanged(auth, callback);
}
