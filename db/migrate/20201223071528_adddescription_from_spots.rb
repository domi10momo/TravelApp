class AdddescriptionFromSpots < ActiveRecord::Migration[6.0]
  def change
    add_column :spots, :description, :string  
    add_column :spots, :address, :string  
  end
end
