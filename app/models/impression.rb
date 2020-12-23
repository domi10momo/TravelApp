class Impression < ApplicationRecord
  belongs_to :myschedule
  belongs_to :spot
end
