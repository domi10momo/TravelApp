class Impression < ApplicationRecord
  belongs_to :my_schedule, optional: true
  belongs_to :spot
end
