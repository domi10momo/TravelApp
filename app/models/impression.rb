class Impression < ApplicationRecord
  belongs_to :myschedule, optional: true
  belongs_to :spot
end
