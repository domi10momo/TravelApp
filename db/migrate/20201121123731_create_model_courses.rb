class CreateModelCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :model_courses do |t|
      t.references :area, null: false, foreign_key: true
      t.float :score
      t.float :distance

      t.timestamps
    end
  end
end
