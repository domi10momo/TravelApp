FactoryBot.define do
  factory :spot do
    association :area
    name {"string"}
    stay_time {100}
    image {"string"}
    description {"string"}
    address {"string"}
  end
end