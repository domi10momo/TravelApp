FactoryBot.define do
  factory :impression do
    association :my_schedule
    association :spot
    text { "string" }
    image { "string" }
  end
end
