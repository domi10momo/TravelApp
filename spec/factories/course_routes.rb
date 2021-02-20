FactoryBot.define do
  factory :course_route do
    association :model_course
    order { 1 }
    association :spot
  end
end
