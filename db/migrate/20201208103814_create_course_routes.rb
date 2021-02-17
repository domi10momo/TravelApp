class CreateCourseRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :course_routes do |t|
      t.references :model_course, null: false, foreign_key: true
      t.integer :order, null: false
      t.references :spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
