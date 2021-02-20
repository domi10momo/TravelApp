FactoryBot.define do
  factory :want do
    association :user
    association :spot
  end
end
