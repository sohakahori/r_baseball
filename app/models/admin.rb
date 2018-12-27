class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # バリデーション
  validates :first_name, presence: {message: "は必須です。"}
  validates :last_name, presence: {message: "は必須です。"}
  validates :role, presence: {message: "は必須です。"}
  validates :email,
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "はメールアドレスを入力してください。" }

  # スコープ
  scope :updated_at_desc, -> { order("updated_at DESC") }
  scope :id_desc, -> { order("id DESC") }
  scope :search_full_name, ->(search_word) { where("concat_ws(' ', last_name, first_name) LIKE ?", "%#{search_word}%") }
  scope :search_email, ->(search_word) { where("email LIKE ?", "%#{search_word}%") }




  def full_name
    "#{self.last_name} #{self.first_name}"
  end
end
