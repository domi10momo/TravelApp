class ModelCoursesController < ApplicationController
  before_action :fetch_areas_and_spots

  def index
    @model_courses = ModelCourse.all
  end

  def show
    # 選択したエリアのコースリストを選択
    @courses_in_area = ModelCourse.where(area_id: area_id)
    @model_routes = CourseRoute.course_ids(@courses_in_area)
  end

  private

  def area_id
    params[:id].to_i
  end

  def fetch_areas_and_spots
    @areas = Area.includes(:spots)
    @spots = Spot.all_spots
    [@areas, @spots]
  end
end
