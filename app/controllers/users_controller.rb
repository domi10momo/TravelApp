class UsersController < ApplicationController
  WANT_SPOT_PER_PAGE = 4   # １ページに表示する感想数
  SCHEDULE_PER_PAGE = 3    # 1ページに表示する旅行予定数
  COURSE_PER_PAGE = 3      # 1ページに表示する完了旅行数

  MAX_COURSE_NUM = 3       # モデルコースの表示数
  MAX_SPOT_NUM = 5         # 観光地の表示数
  MAX_IMPRESSION_NUM = 5   # 感想の表示数

  def index
    @example_model_courses = ModelCourse.eager_load(:course_routes).where(area_id: 1).limit(MAX_COURSE_NUM)
    @spots = Spot.preload(:area, :wants, :wanted_users).limit(MAX_SPOT_NUM)
    @impressions = Impression.eager_load(:spot, :my_schedule).order(created_at: "DESC").limit(MAX_IMPRESSION_NUM)
  end

  def show
    @spots = Spot.preload(:area)
    @want_spots = current_user.wanted_spots.page(params[:want_page]).per(WANT_SPOT_PER_PAGE)
    @my_schedules = MySchedule.eager_load(:my_travel_courses, :route_spots, my_travel_courses: [:spot])
                              .where(user_id: current_user)
    @gone_false_schedules = Kaminari.paginate_array(@my_schedules.gone_flag(false))
                                    .page(params[:not_gone_page])
                                    .per(SCHEDULE_PER_PAGE)
    @gone_true_schedules = Kaminari.paginate_array(@my_schedules.gone_flag(true))
                                   .page(params[:gone_page])
                                   .per(COURSE_PER_PAGE)
  end
end
