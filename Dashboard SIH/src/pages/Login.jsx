import React, { useState } from "react";
import { signInWithEmailAndPassword } from "firebase/auth";
import { auth } from "../firebase-config";
import { UserContext } from "../contexts/ContextProvider";
import { FaUserFriends } from 'react-icons/fa';
import { FaUserCircle } from 'react-icons/fa'
import { BsKeyFill } from 'react-icons/bs'
import BackgroundImage from '../data/law_justice.jpg';

const Login = () => {
  const { setUser } = React.useContext(UserContext);

  const [LoginId, setLoginId] = useState("");
  const [LoginPassword, setLoginPassword] = useState("");
  const [selectedRole, setSelectedRole] = useState("lawyer");

  const handleRoleChange = (event) => {
    setSelectedRole(event.target.value);
  };

  const handleLogin = async () => {
    try {
      const userCredential = await signInWithEmailAndPassword(
        auth,
        LoginId,
        LoginPassword
      );

      setUser(selectedRole);

      // Redirect to the Home page
      window.location.href = "/Home";
    } catch (error) {
      alert("Wrong Credentials");
    }
  };

  return (
    <div>
      <section className=" m-auto bg-gray-50 dark:bg-gray-900 "  style={{ backgroundImage: `url(${BackgroundImage})`, backgroundSize: 'cover', backgroundRepeat: 'no-repeat' }}>
        
        <div>
          <h1 className=" bg-white bg-opacity-100 pl-3 pt-3 pb-3 rounded flex items-end text-sky-700 bg-grey-50 font-bold text-xl mb-32 relative left-6 top-6 " style={{ width: '150px' }}>NyaySanvad</h1>
        </div>
        
        <div className="flex flex-col items-center  mt-50 px-6 py-8 mx-auto md:h-screen lg:py-0">
          <div className=" w-400 opacity-90  bg-white rounded-xl shadow-[0_25px_50px_-15px_rgba(0,0,0,1)] dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700">
            <div className="p-6 space-y-4 md:space-y-6 sm:p-8">
              <h1 className="text-center font-extrabold leading-tight tracking-tight text-black dark:text-white" style={{fontSize: 'rem'}}>
                Welcome Back
              </h1>

              <form className=" space-y-4 md:space-y-6" action="#">
                <br />

                {/* DropDown */}
                <div className="justify-center flex flex-row items-center">
                  <div className="relative inline-block text-gray-700 dark:text-gray-200">
                    <select
                      id="role"
                      name="role"
                      placeholder="Enter your role"
                      className="w-72 bg-slate-200 border border-gray-300 text-gray-900 sm:text-sm rounded-l-lg focus:ring-primary-600 focus:border-primary-600 block p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                      required=""
                      onChange={handleRoleChange}
                    >
                      <option value="select">Select your Role</option>
                      <option value="lawyer">Lawyer</option>
                      <option value="admin">Admin</option>
                      <option value="general">General</option>
                    </select>
                  </div>
                  <div className='relative bg-white border p-2 rounded-r-lg'>
                    <FaUserFriends size={25} />
                  </div>
                </div>

                <div className=" justify-center flex flex-row items-center">
                  <input
                    type="text"
                    name="userID"
                    id="userID"
                    className="w-72 bg-slate-200 border border-gray-300 text-gray-900 sm:text-sm rounded-l-lg focus:ring-primary-600 focus:border-primary-600 block p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                    placeholder="Enter your user ID"
                    onChange={(event) => {
                      setLoginId(event.target.value + "@gmail.com");
                    }}
                    required=""
                  />
                  <div className='relative bg-white border p-2 rounded-r-lg'>
                    <FaUserCircle size={25} />
                  </div>
                </div>

                <div className="justify-center flex flex-row items-center">
                  <input
                    type="password"
                    name="password"
                    id="password"
                    placeholder="Enter your Password"
                    onChange={(event) => {
                      setLoginPassword(event.target.value);
                    }}
                    className="w-72 bg-slate-200 border border-gray-300 text-gray-900 sm:text-sm rounded-l-lg focus:ring-primary-600 focus:border-primary-600 block p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                    required=""
                  />
                  <div className='relative bg-white p-2 border rounded-r-lg'>
                    <BsKeyFill size={25} />
                  </div>
                </div>

                <div className="text-center">
                  <button
                    onClick={handleLogin}
                    type="button"
                    className="mt-6 items-center justify-center text-base bg-blue-500 hover:bg-blue-700 text-white m-4 font-bold py-2 px-12 rounded"
                  >
                    LOGIN
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
};

export default Login;
