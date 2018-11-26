class Board < ApplicationRecord

  # バリデーション
  validates :title, presence: true,
            length: { maximum: 30 }

  # アソシエーション
  belongs_to :user

  # スコープ
  scope :search_title, ->(title) { where("title LIKE ?", "%#{title}%") }
end
