class ImpressionsController < ApplicationController
  def index
    @impressions = Impression.order(created_at: "DESC")
  end

  def new
    @choice_spot = MyTravelCourse.find(param_format)
    @gone_date = MySchedule.travel_date(@choice_spot)
    @spot_name = Spot.id_name(@choice_spot)
  end

  def create
    @choice_spot = MyTravelCourse.find(param_format)
    Impression.create!(
      my_schedule_id: @choice_spot.my_schedule_id,
      spot_id: @choice_spot.spot_id,
      text: params_impression[:text],
      image: params_impression[:image]
    )
    updated_my_travel_course
    redirect_to impressions_path
  end

  private

  def param_format
    params.require(:format)
  end

  def params_impression
    params.require(:my_travel_course).permit(:text, :image)
  end

  def updated_my_travel_course
    @travel_spot = MyTravelCourse.find(params[:format])
    @travel_spot.update(fill_in_impression: true)
  end
end
