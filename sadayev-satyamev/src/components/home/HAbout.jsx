import React from "react"
import OnlineCourses from "../allcourses/OnlineCourses"
import Heading from "../common/header/Heading"
import "../allcourses/courses.css"
import { coursesCard } from "../../dummydata"

const HAbout = () => {
  return (
    <>
      <section className='homeAbout'>
        <div className='container'>
          <Heading subtitle='LEGAL RIGHTS' title='Rights for the protection of Undertrial Prisoner' />

          <div className='coursesCard'>
            {/* copy code form  coursesCard */}
            <div className='grid2'>
              {coursesCard.slice(0, 3).map((val) => (
                <div className='items'>
                  <div className='content flex'>
                    <div className='left'>
                      <div className='img'>
                        <img src={val.cover} alt='' />
                      </div>
                    </div>
                    <div className='text'>
                      <h1>{val.coursesName}</h1>
                      
                    </div>
                  </div>
                  <div className='price'>
                    <h3>
                      {val.priceAll} 
                    </h3>
                  </div>
                  <button className='outline-btn'>Read More !</button>
                </div>
              ))}
            </div>
          </div>
        </div>
        <OnlineCourses />
      </section>
    </>
  )
}

export default HAbout
