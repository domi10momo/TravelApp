class Spot < ApplicationRecord
  belongs_to :area
  has_many :wants, dependent: :destroy
  has_many :wanted_users, through: :wants, source: :user
  has_many :distances, dependent: :destroy
  has_many :course_routes, dependent: :destroy
  validates :name, presence: true
  validates :stay_time, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :address, presence: true
  validates :image, presence: true
  scope :id_name, ->(spot) { find(spot.spot_id).name }
  scope :id_description, ->(spot) { find(spot.spot_id).description }
  scope :id_image, ->(spot) { find(spot.spot_id).image }

  def wanted_by?(user)
    wants.where(user_id: user.id).exists?
  end

  class << self
    def all_spots
      Spot.includes(:area)
    end
  end
end
