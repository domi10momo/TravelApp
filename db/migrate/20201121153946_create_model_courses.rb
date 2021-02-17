class CreateModelCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :model_courses do |t|
      t.references :area, null: false, foreign_key: true
      t.integer :course_number, null: false
      t.float :score, null: false
      t.float :distance, null: false

      t.timestamps
    end
  end
end
