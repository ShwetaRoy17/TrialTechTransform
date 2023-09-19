import React from "react"
import { price } from "../../dummydata"


const PriceCard = () => {
  return (
    <>
      {price.map((val) => (
        <div className='items shadow'>
          <h4>{val.name}</h4>
          
          <p className="justify-text">{val.desc}</p>
          <button className='outline-btn button-align-bottom'>EXPLORE</button>
        </div>
      ))}
    </>
  )
}

export default PriceCard
