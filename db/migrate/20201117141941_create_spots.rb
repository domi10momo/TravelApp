class CreateSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :spots do |t|
      t.references :area, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :stay_time
      t.string :image, null: false

      t.timestamps
    end
  end
end
