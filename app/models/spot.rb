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
  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :image, presence: true

  def wanted_by?(user)
    wants.where(user_id: user.id).exists?
  end
end
