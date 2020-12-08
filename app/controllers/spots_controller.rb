class SpotsController < ApplicationController
  def index
    @spots = Spot.all_spots
  end
end