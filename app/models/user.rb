class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :spots, dependent: :destroy
  has_many :wants, dependent: :destroy
  has_many :wanted_spots, through: :wants, source: :spot
  has_many :my_schedules
end
