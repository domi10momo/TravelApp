class CreateSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :spots do |t|
      t.references :area, null: false, foreign_key: true
      t.string :name
      t.integer :stay_time
      t.string :image

      t.timestamps
    end
  end
end
