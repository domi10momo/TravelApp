FactoryBot.define do
  factory :my_travel_course do
    association :my_schedule
    order { 1 }
    association :spot
    fill_in_impression { "false" }
  end
end
