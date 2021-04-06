class ModelCoursesController < ApplicationController
  before_action :fetch_areas_and_spots
  NUMBER_PER_PAGE = 10  # 1ページ当たりの表示コース数 * 1コースの観光地数

  def index
    @model_courses = ModelCourse.includes(:area)
  end

  def show
    # 選択したエリアのコースリストを選択
    #area = Area.find(area_id)
    @courses_in_area = ModelCourse.eager_load(:course_routes).where(area_id: area_id)
                                  .order(score: "ASC").order(order: "ASC")
                                  .page(params[:page]).per(NUMBER_PER_PAGE)
  end

  private

  def area_id
    params[:id].to_i
  end

  def fetch_areas_and_spots
    @areas = Area.preload(:spots)
    @spots = Spot.preload(:area)
    [@areas, @spots]
  end
end
