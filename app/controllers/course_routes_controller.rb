class CourseRoutesController < ApplicationController
  def show
    @spots = Spot.includes(:area)
    @course_route = CourseRoute.course(course_id)
  end

  private
  def course_id
    params.require(:id)
  end
end