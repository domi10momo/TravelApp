class CourseRoutesController < ApplicationController
  def show
    @spots = Spot.includes(:area)
    @course_route = ModelCourse.find(course_id).course_routes
  end

  private

  def course_id
    params.require(:id)
  end
end
