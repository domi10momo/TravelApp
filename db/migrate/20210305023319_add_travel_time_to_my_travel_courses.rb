class AddTravelTimeToMyTravelCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :my_travel_courses, :next_distance, :float, null: false
    add_column :my_travel_courses, :next_time, :integer, null: false
  end
end
