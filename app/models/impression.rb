class Impression < ApplicationRecord
  belongs_to :my_schedule
  belongs_to :spot
  validates :text, presence: true, length: {minimum: 10, maximum: 200}
  mount_uploader :image, SpotUploader
end
