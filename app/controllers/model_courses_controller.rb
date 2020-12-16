class ModelCoursesController < ApplicationController
  def index
    @areas, spots = fetch_areas_and_spots
    @model_courses = ModelCourse.all
  end

  def show
    @areas, @spots = fetch_areas_and_spots
    featch_course_lists(@areas, @spots)
    #選択したエリアのコースリストを選択
    @courses_in_area = ModelCourse.where(area_id: params[:id].to_i)
    binding.pry    
    @model_course_routes = CourseRoute.all
  end

  def make_course
    @areas, @spots = fetch_areas_and_spots
    ModelCourse.make_model_course(@areas, @spots)
  end
end