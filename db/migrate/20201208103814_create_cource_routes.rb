class CreateCourceRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :cource_routes do |t|
      t.references :model_course, null: false, foreign_key: true
      t.integer :order
      t.references :spot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
