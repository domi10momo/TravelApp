class ImpressionsController < ApplicationController
  def index
  end

  def new
    @choice_spot = MyTravelCourse.find(params[:format])
    @gone_date = MySchedule.find_by(id: @choice_spot.my_schedule_id).date
    @spot_name = Spot.find(@choice_spot.spot_id).name
  end

  def create
    @choice_spot = MyTravelCourse.find(params[:format])
    binding.pry
    Impression.create!(
      my_schedule_id: @choice_spot.my_schedule_id,
      spot_id: @choice_spot.spot_id,
      text: params[:my_travel_course][:text],
      image: nil
    )
  end
end
