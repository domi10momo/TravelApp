class SpotsController < ApplicationController
  def index
    @spots = Spot.all_spots
  end

  def show
    @spot = Spot.find(show_param)
  end

  private

    def show_param
      params.require(:id)
    end
end