class Response < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :board

  validates :body, presence: true
end
