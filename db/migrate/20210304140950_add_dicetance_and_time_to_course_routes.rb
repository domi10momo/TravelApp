class AddDicetanceAndTimeToCourseRoutes < ActiveRecord::Migration[6.0]
  def change
    add_column :course_routes, :next_distance, :float, null: false
    add_column :course_routes, :next_time, :integer, null: false
  end
end
