class Distance < ApplicationRecord
  require 'csv'
  require 'net/http'
  require 'uri'
  require 'json'
  belongs_to :spot
  
  def csv_export(areas, spots)
    spots_permutation = self.get_permutation(areas, spots)
    csv_export_routes(spots_permutation, spots)
    
  end

  def get_permutation(areas, spots)
    permutation_list = []
    areas.each do |area|
      permutation_list << spots.where(area_id:area.id).ids.permutation(2).to_a
    end
    permutation_list
  end

  def csv_export_routes(spots_permutation, spots)
    CSV.open('db/csv_data/distance.csv', 'a') do |csv|
      spots_permutation.each do |spots_in_one_area|
        spots_in_one_area.each do |distance_list|
          distance_value, time_value = set_distance_and_time(distance_list, spots)
          csv << [
            distance_list[0],
            distance_list[1],
            distance_value,
            time_value
          ]
        end
      end
    end
  end

  def set_distance_and_time(distance_list, spots)
    fetch_api = fetch_direction_api(distance_list, spots)
    distance_value = fetch_api["routes"][0]["legs"][0]["distance"]["text"]
    time_value = fetch_api["routes"][0]["legs"][0]["duration"]["text"]
    distance_value = distance_value.delete(" km").to_f
    time_value = time_value.delete(" mins").to_i
    return distance_value, time_value
  end

  def fetch_direction_api(distance_list, spots)
    origin = spots.find(distance_list[0]).name
    destination = spots.find(distance_list[1]).name
    uri = URI.parse URI.encode("https://maps.googleapis.com/maps/api/directions/json?origin=\"#{origin}\"&destination=\"#{destination}\"&key=#{ENV['API_KEY']}")
    p uri
    json = Net::HTTP.get(uri)
    api_result = JSON.parse(json)
    api_result
  end
end
