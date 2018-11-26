class Board < ApplicationRecord

  validates :title, presence: true,
            length: { maximum: 30 }

  # アソシエーション
  belongs_to :user
end
