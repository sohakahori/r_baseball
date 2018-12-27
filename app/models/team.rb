class Team < ApplicationRecord

  mount_uploader :main_image, Admin::Teams::MainImageUploader

  # アソシエーション
  has_many :players, :dependent => :destroy

  # スコープ
  scope :order_league, -> { order(:league) }

  # バリデーション
  validates :name, presence: { message: 'は必須です。' }
  validates :league, presence: { message: 'は必須です。' }
  validates :stadium, presence: { message: 'は必須です。' }
  validates :address, presence: { message: 'は必須です。' }

  def get_league_name
    self.league == '1' ? 'セントラル' : 'パフィシック'
  end
end
