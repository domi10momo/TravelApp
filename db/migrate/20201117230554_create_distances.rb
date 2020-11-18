class CreateDistances < ActiveRecord::Migration[6.0]
  def change
    create_table :distances do |t|
      t.references :start_spot, null: false
      t.references :end_spot, null: false
      t.float :value
      t.integer :travel_time

      t.timestamps
    end
    add_foreign_key :distances, :spots, column: :start_spot_id
    add_foreign_key :distances, :spots, column: :end_spot_id
  end
end
