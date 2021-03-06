class Area < ApplicationRecord
  has_many :spots, dependent: :destroy
  has_many :model_courses, dependent: :destroy
  validates :name, presence: true
end
