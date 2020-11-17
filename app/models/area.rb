class Area < ApplicationRecord
  has_many :spots, dependent: :destroy
end
