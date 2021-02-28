class ModelCoursesController < ApplicationController
  before_action :fetch_areas_and_spots
  NUMBER_PER_PAGE = 10  # 1ページ当たりの表示コース数

  def index
    @model_courses = ModelCourse.all
  end

  def show
    # 選択したエリアのコースリストを選択
    @courses_in_area = ModelCourse.where(area_id: area_id).order(score: "ASC").page(params[:page]).per(NUMBER_PER_PAGE)
    @model_routes = CourseRoute.course_ids(@courses_in_area)
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
