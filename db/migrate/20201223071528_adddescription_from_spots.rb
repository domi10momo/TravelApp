class AdddescriptionFromSpots < ActiveRecord::Migration[6.0]
  def change
    add_column :spots, :description, :string, null: false
    add_column :spots, :address, :string, null: false
  end
end
