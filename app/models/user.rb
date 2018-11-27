class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  # アソシエーション
  has_many :boards

  # バリデーション
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :nickname, presence: true
end
