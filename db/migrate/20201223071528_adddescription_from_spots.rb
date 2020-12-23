class AdddescriptionFromSpots < ActiveRecord::Migration[6.0]
  def change
    add_column :spots, :description, :string    
  end
end
