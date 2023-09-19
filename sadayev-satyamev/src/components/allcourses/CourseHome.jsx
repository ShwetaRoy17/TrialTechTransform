import React from "react"
import Back from "../common/back/Back"
import CoursesCard from "./CoursesCard"
import OnlineCourses from "./OnlineCourses"

const CourseHome = () => {
  return (
    <>
      <Back title='Rights and Legal Resources' quote='Unlock Your Rights with Legal Insight'/>
      <CoursesCard />
      <OnlineCourses />
    </>
  )
}

export default CourseHome
