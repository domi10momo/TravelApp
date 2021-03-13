class CourseParam
  def initialize
    @model_course_id = 0
    @route_id = 0   # course_routesテーブルのid
    @order_number = 0   # 観光順序を表す値
  end

  def upper_course_id
    @model_course_id += 1
  end

  def upper_route_id
    @route_id += 1
  end

  def upper_order_number
    @order_number += 1
  end

  def order_reset
    @order_number = 0
  end
end
