class AddTotalTimeToModelCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :model_courses, :total_time, :integer, null: false
  end
end
