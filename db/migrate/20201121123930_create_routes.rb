class CreateRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :routes do |t|
      t.references :model_course, null: false, foreign_key: true
      t.references :distance, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
