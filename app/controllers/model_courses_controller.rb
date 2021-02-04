class ModelCoursesController < ApplicationController
  before_action :fetch_areas_and_spots

  def index
    @model_courses = ModelCourse.all
  end

  def show
    # 選択したエリアのコースリストを選択
    @courses_in_area = ModelCourse.where(area_id: area_id).order(score: "ASC").page(params[:page]).per(10)
    @model_routes = CourseRoute.course_ids(@courses_in_area)
    # @want_spots = current_user.wanted_spots
    # @courses_in_area = Want.create_calc_course_score(@courses_in_area, @model_routes, @want_spots)
  end

  private

  def area_id
    params[:id].to_i
  end

  def fetch_areas_and_spots
    @areas = Area.all
    @spots = Spot.all
    [@areas, @spots]
  end
end
