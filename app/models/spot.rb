class Spot < ApplicationRecord
  belongs_to :area
  has_many :wants, dependent: :destroy
  has_many :wanted_users, through: :wants, source: :user
  has_many :start_spots, class_name: "distance", foreign_key: "start_spot_id",
                         dependent: :destroy, inverse_of: :start_spot
  has_many :end_spots, class_name: "distance", foreign_key: "end_spot_id", dependent: :destroy, inverse_of: :end_spot
  has_many :course_routes, dependent: :destroy
  has_many :my_travel_courses, dependent: :destroy
  has_many :impressions, dependent: :destroy
  validates :name, presence: true, length: {minimum: 1, maximum: 30}
  validates :description, presence: true, length: {minimum: 1, maximum: 120}
  validates :address, presence: true, length: {minimum: 1, maximum: 60}
  validates :image, presence: true, length: {minimum: 1, maximum: 60}

  def wanted_by?(user)
    wants.where(user_id: user.id).exists?
  end
end
