class WantsController < ApplicationController
  before_action :tables

  def create
    current_user.wants.create!(spot_id: param_spot_id)
    Want.change_score(@model_courses, @course_routes, param_spot_id)
    redirect_to spots_path
  end

  def destroy
    current_user.wants.find_by(spot_id: param_spot_id).destroy!
    redirect_to spots_path
  end

  private

  def param_spot_id
    params.require(:spot_id)
  end

  def tables
    @model_courses = ModelCourse.all
    @course_routes = CourseRoute.all
  end
end
