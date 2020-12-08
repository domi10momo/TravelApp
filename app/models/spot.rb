class Spot < ApplicationRecord
  belongs_to :area
  has_many :wants, dependent: :destroy
  has_many :wanted_users, through: :wants, source: :user

  def wanted_by?(user)
    wants.where(user_id: user.id).exists?
  end
end
