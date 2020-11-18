class Distance < ApplicationRecord
  require 'csv'
  require 'net/http'
  require 'uri'
  require 'json'
  belongs_to :spot
  
  def csv_export(areas, spots)
    spots_permutation = self.get_permutation(areas, spots)
    csv_export_routes(spots_permutation)
    
  end

  def get_permutation(areas, spots)
    permutation_list = []
    areas.each do |area|
      permutation_list << spots.where(area_id:area.id).ids.permutation(2).to_a
    end
    permutation_list
  end

  def csv_export_routes(spots_permutation)
    CSV.open('db/csv_data/distance.csv', 'a') do |csv|
      spots_permutation.each do |spots_in_one_area|
        spots_in_one_area.each do |distance_list|
          csv << [distance_list[0], distance_list[1],0,0]
        end
      end
    end
  end
end
