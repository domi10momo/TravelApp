class ModelCoursesController < ApplicationController
  def index
    @areas, spots = fetch_areas_and_spots
    @model_courses = ModelCourse.all
  end

  def show
    @areas, @spots = fetch_areas_and_spots
    #選択したエリアのコースリストを選択
    @courses_in_area = ModelCourse.where(area_id: params[:id].to_i)  
    @model_course_routes = CourseRoute.includes(:model_course)
                                      .where(model_course_id: @courses_in_area.ids)
  end

  def make_course
    @areas, @spots = fetch_areas_and_spots
    ModelCourse.make_model_course(@areas, @spots)
  end
end