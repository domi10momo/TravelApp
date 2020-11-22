class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(current_user.id)
    @spots = Spot.includes(:city)
    @want_spots = @user.wanted_spots
  end
end
