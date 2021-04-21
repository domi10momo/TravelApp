class ImpressionsController < ApplicationController
  before_action :message_is_empty, only: [:create]
  before_action :message_length_over, only: [:create]

  MAX_IMPRESSION_NUM = 100  # 最大表示感想数
  IMPRESSION_PER_PAGE = 5   # １ページに表示する感想数
  MAX_TEXT_LENGTH = 500   # 感想文の最大文字数

  def index
    @impressions = Impression.eager_load(:spot, :my_schedule).order(created_at: "DESC").limit(MAX_IMPRESSION_NUM)
                             .page(params[:page]).per(IMPRESSION_PER_PAGE)
  end

  def new
    @choice_spot = MyTravelCourse.eager_load(:my_schedule, :spot).find(param_format)
  end

  def create
    @choice_spot = MyTravelCourse.eager_load(:my_schedule, :spot).find(param_format)
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

  def message_is_empty
    redirect_to new_impression_path(param_format), danger: "感想を入力してください" unless params_impression[:text]
  end

  def message_length_over
    return unless params_impression[:text].length > MAX_TEXT_LENGTH

    flash[:danger] = "感想は300文字以内で入力してください"
    render :new
  end
end
