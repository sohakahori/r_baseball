class Response < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :board

  validates :body, presence: true

  # スコープ
  scope :search_like_body, ->(search_like_body) { where("body LIKE ?", "%#{search_like_body}%") }
end
