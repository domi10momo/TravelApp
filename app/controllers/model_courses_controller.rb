class ModelCoursesController < ApplicationController
  NUMBER_PER_PAGE = 10  # 1ページ当たりの表示コース数 * 1コースの観光地数

  def index
    @areas = Area.preload(:spots)
  end

  def show
    # 選択したエリアのコースリストを選択
    @courses_in_area = ModelCourse.eager_load(:course_routes)
                                  .where(area_id: area_id).order(score: "ASC")
                                  .page(params[:page]).per(NUMBER_PER_PAGE)
  end

  private

  def area_id
    params[:id].to_i
  end
end
