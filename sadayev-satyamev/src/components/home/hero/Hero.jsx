import React from "react"
import Heading from "../../common/header/Heading"
import "./Hero.css"

const Hero = () => {
  return (
    <>
      <section className='hero'>
        <div className='container'>
          <div className='row'>
            <Heading subtitle='WELCOME TO SADAYEV SATYAMEV' title='Empowering Undertrial Prisoners with Legal Knowledge and Support' />
            <p class="intro para">we are committed to ensure that individuals facing legal challenges have access to comprehensive guides, articles, and resources to protect their rights.</p>
            
          </div>
        </div>
      </section>
      <div className='margin'></div>
    </>
  )
}

export default Hero
