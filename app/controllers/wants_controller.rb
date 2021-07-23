class WantsController < ApplicationController
  before_action :tables
  WANT_SCORE_WEIGHT = 0.1   # 行きたい観光地に登録した際のスコア減少のウェイト
  RESTORE_SCORE_WEIGHT = 1 / WANT_SCORE_WEIGHT  # 行きたい観光地解除した際にスコアを戻すためのウェイト

  def create
    @want_spot = Spot.find(param_spot_id)
    current_user.wants.create!(spot_id: param_spot_id)
    Want.change_score(@course_routes, param_spot_id, WANT_SCORE_WEIGHT)
  end

  def destroy
    @want_spot = Spot.find(param_spot_id)
    current_user.wants.find_by(spot_id: param_spot_id).destroy!
    Want.change_score(@course_routes, param_spot_id, RESTORE_SCORE_WEIGHT)
  end

  private

  def param_spot_id
    params.require(:spot_id)
  end

  def tables
    @course_routes = CourseRoute.preload(:model_course)
  end
end
