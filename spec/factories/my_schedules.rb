FactoryBot.define do
  factory :my_schedule do
    association :user
    date { Time.zone.now }
    gone { "false" }
  end
end
