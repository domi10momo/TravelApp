class WantsController < ApplicationController
  def create
    current_user.wants.create!(spot_id: param_spot_id)
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
end
