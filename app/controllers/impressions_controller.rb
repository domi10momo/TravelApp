class ImpressionsController < ApplicationController
  def index
    @impressions = Impression.order(created_at: "DESC").limit(100).page(params[:page]).per(5)
  end

  def new
    @choice_spot = MyTravelCourse.find(param_format)
    @gone_date = @choice_spot.my_schedule.date
    @spot_name = @choice_spot.spot.name
  end

  def create
    @choice_spot = MyTravelCourse.find(param_format)
    Impression.create!(
      my_schedule_id: @choice_spot.my_schedule_id,
      spot_id: @choice_spot.spot_id,
      text: params_impression[:text],
      image: params_impression[:image]
    )
    @choice_spot.update(fill_in_impression: true)
    redirect_to impressions_path
  end

  private

  def param_format
    params.require(:format)
  end

  def params_impression
    params.require(:my_travel_course).permit(:text, :image)
  end
end
