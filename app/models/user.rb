class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :wants, dependent: :destroy
  has_many :wanted_spots, through: :wants, source: :spot
  has_many :my_schedules, dependent: :destroy
  validates :email, presence: true
  validates :nickname, presence: true

  scope :id_name, ->(table) { find(table.user_id).nickname }

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.nickname = "鈴木 悟"
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
