class ModelCoursesController < ApplicationController
  before_action :fetch_areas_and_spots

  def index
    @model_courses = ModelCourse.all
  end

  def show
    #選択したエリアのコースリストを選択
    @courses_in_area = ModelCourse.where(area_id: area_id)  
    @model_course_routes = CourseRoute.includes(:model_course)
                                      .where(model_course_id: @courses_in_area.ids)
  end

  def make_course
    ModelCourse.make_model_course(@areas, @spots)
  end

  private

  def area_id
    params[:id].to_i
  end

  def fetch_areas_and_spots
    @areas = Area.includes(:spots)
    @spots = Spot.all_spots
    return @areas, @spots
  end

end