class SpotsController < ApplicationController
  def index
    @spots = Spot.includes(:area)
    @wanted_spot_ids = current_user.wants.pluck(:spot_id)
  end

  def show
    @spot = gon.spot = Spot.find(show_param)
    @wanted_spot_ids = current_user.wants.pluck(:spot_id)
    @map_url = "https://maps.googleapis.com/maps/api/js?key=#{Rails.application.credentials.MAP_API_KEY}"
  end

  private

  def show_param
    params.require(:id)
  end
end
