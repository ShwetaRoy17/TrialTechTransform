import React from "react"
import { useLocation } from "react-router-dom"

const Back = ({ title,quote }) => {
  const location = useLocation()

  return (
    <>
      <section className='back'>
        <h1>{title}</h1>
        <h2>{quote}</h2>
      </section>
      <div className='margin'></div>
    </>
  )
}

export default Back
