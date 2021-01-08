class RemoveCourseNumberFromModelCourses < ActiveRecord::Migration[6.0]
  def change
    remove_column :model_courses, :course_number, :integer
  end
end
