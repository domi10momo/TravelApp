class Distance < ApplicationRecord
  require 'csv'
  require 'net/http'
  require 'uri'
  require 'json'
  POINT_NUMBER_2 = 2  #２地点
  POIUT_NUMBER_5 = 5  #course内の地点数（5地点）
  belongs_to :spot

  def get_course_list(areas, spots)
    all_course = self.get_permutation(areas, spots, POIUT_NUMBER_5)
    binding.pry
  end

  def csv_export(areas, spots)
    spots_permutation = self.get_permutation(areas, spots, POINT_NUMBER_2)
    csv_export_routes(spots_permutation, spots)
  end

  #エリア毎に(POINT_NUMBER)地点を選ぶ組み合わせをpermutation_listに格納
  def get_permutation(areas, spots, point_number)
    permutation_list = []
    areas.each do |area|
      permutation_list << spots.where(area_id:area.id).ids.permutation(point_number).to_a
    end
    permutation_list
  end

  #csvに値を書き出す
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

  #directions apiから値取得し、テーブル用の数値型に変換する
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
    json = Net::HTTP.get(uri)
    api_result = JSON.parse(json)
    api_result
  end


end
