class Impression < ApplicationRecord
  belongs_to :my_schedule
  belongs_to :spot
  validates :text, presence: true
  mount_uploader :image, SpotUploader
end
