class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  # アソシエーション
  has_many :boards, dependent: :destroy
  has_many :responses, dependent: :destroy

  # バリデーション
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :nickname, presence: true

  # スコープ
  # scope :search_like_with_first_name, ->(search_word) { where("first_name LIKE ?", "%#{search_word}%") }
  # scope :search_like_with_last_name, ->(search_word) { where("last_name LIKE ?", "%#{search_word}%") }
  # scope :search_like_with_nickname, ->(search_word) { where("nickname LIKE ?", "%#{search_word}%") }
  # scope :search_like_with_email, ->(search_word) { where("email LIKE ?", "%#{search_word}%") }
  # scope :search_like_with_full_name, ->(search_word) { where("concat_ws(' ', last_name, first_name) like ?", "%#{search_word}%") }
  scope :search_like_users, ->(search_word) {
    where("first_name LIKE ?", "%#{search_word}%")
    .or(where("last_name LIKE ?", "%#{search_word}%"))
    .or(where("nickname LIKE ?", "%#{search_word}%"))
    .or(where("email LIKE ?", "%#{search_word}%"))
    .or(where("concat_ws(' ', last_name, first_name) like ?", "%#{search_word}%"))
  }

  def get_full_name
    self.last_name + " " + self.first_name
  end
end
