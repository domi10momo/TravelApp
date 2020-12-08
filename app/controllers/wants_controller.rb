class WantsController < ApplicationController
  def create
    current_user.wants.create!(spot_id: params[:spot_id])
    redirect_to spots_path
  end

  def destroy
    current_user.wants.find_by(spot_id: params[:spot_id]).destroy!
    redirect_to spots_path
  end
end