FactoryBot.define do
  factory :model_course do
    association :area
    score { 1.1 }
    distance { 1.1 }
  end
end
