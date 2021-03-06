class Distance < ApplicationRecord
  require "csv"
  require "net/http"
  require "uri"
  require "json"
  validates :value, numericality: { greater_than_or_equal_to: 0 }
  validates :travel_time, numericality: { greater_than_or_equal_to: 0 }

  POINT_NUMBER_2 = 2  # 2地点
  POINT_NUMBER_5 = 5  # course内の地点数（5地点）
  belongs_to :start_spot, class_name: "Spot", inverse_of: :start_spots
  belongs_to :end_spot, class_name: "Spot", inverse_of: :end_spots

  class << self
    def fetch_next_distance_and_time(start_id, end_id)
      Distance.find_by(
        start_spot_id: start_id,
        end_spot_id: end_id
      )
    end

    def get_course_list(areas, spots)
      get_permutation(areas, spots, POINT_NUMBER_5)
    end

    def csv_export(areas, spots)
      spots_permutation = get_permutation(areas, spots, POINT_NUMBER_2)
      csv_export_distance(spots_permutation, spots)
    end

    # エリア毎に(POINT_NUMBER)地点を選ぶ組み合わせをpermutation_listに格納
    def get_permutation(areas, spots, point_number)
      permutation_list = []
      areas.each do |area|
        permutation_list << spots.where(area_id: area.id).ids.permutation(point_number).to_a
      end
      permutation_list
    end

    # csvに値を書き出す
    def csv_export_distance(spots_permutation, spots)
      CSV.open("db/csv_data/distance.csv", "a") do |csv|
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

    # directions apiから値取得し、テーブル用の数値型に変換する
    def set_distance_and_time(distance_list, spots)
      fetch_api = fetch_direction_api(distance_list, spots)
      distance_value = api_value(fetch_api, "distance").delete(" km").to_f
      time_value = api_value(fetch_api, "duration").delete(" mins").to_i
      [distance_value, time_value]
    end

    def api_value(fetch_api, column)
      fetch_api["routes"][0]["legs"][0][column]["text"]
    end

    def fetch_direction_api(distance_list, spots)
      origin = spots.find(distance_list[0]).name
      destination = spots.find(distance_list[1]).name
      api_url = "https://maps.googleapis.com/maps/api/directions/json"
      two_spots_url = "origin=\"#{origin}\"&destination=\"#{destination}\""
      uri = Addressable::URI.encode("#{api_url}?#{two_spots_url}&key=#{ENV['API_KEY']}")
      json = Net::HTTP.get(uri)
      JSON.parse(json)
    end
  end
end
