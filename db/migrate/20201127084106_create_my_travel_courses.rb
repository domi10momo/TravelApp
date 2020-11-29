class CreateMyTravelCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :my_travel_courses do |t|
      t.references :my_schedule, null: false, foreign_key: true
      t.integer :order
      t.references :spot, null: false, foreign_key: true
      t.string :impression
      t.string :image
      t.boolean :gone

      t.timestamps
    end
  end
end
