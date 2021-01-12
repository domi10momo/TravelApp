class Impression < ApplicationRecord
  belongs_to :my_schedule, optional: true
  belongs_to :spot
  mount_uploader :image, SpotUploader
end
