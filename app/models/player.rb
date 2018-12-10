class Player < ApplicationRecord

  mount_uploader :image, Admin::Players::ImageUploader

  enum throw: { right_throw: 1, left_throw: 2 }
  enum hit: { right_hit: 1, left_hit: 2, switch_hit: 3}
  enum position: {
      pitcher: 1,
      catcher: 2,
      first_baseman: 3,
      second_baseman: 4,
      third_baseman: 5,
      shortstop: 6,
      left_fielder: 7,
      center_fielder: 8,
      right_fielder: 9,
  }


  # アソシエーション
  belongs_to :team

  # スコープ
  scope :search_team, ->(team_id) { where('team_id = ?', team_id) }
  scope :search_name, ->(search_word) { where("name LIKE ?", "%#{search_word}%") }
  scope :search_no, ->(search_word) { where(no: search_word) }

  # バリデーション
  validates :no,
            presence: { message: 'は必須です。'},
            numericality: { only_integer: true, message: 'は数値で入力してください。'}
  validates :name,
            presence: { message: 'は必須です。'}
  validates :birthday,
            presence: { message: 'は必須です。'}
  validates :position,
            presence: { message: 'は必須です。'}
  validates :height,
            presence: { message: 'は必須です。'},
            numericality: { message: 'は数値で入力してください。'},
            length: { in: 2..3, message: 'は2〜3桁の範囲で入力してください。' }
  validates :weight,
            presence: { message: 'は必須です。'},
            numericality: { message: 'は数値で入力してください。'},
            length: { in: 2..3, message: 'は2〜3桁の範囲で入力してください。' }
  validates :throw,
            presence: { message: 'は必須です。'}
  validates :hit,
            presence: { message: 'は必須です。'}


  def self.import_player file
    current_player_count = self.count
    players = []
    CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
      players << self.new(
          team: @team,
          no: row["no"],
          name: row["name"],
          position: row["position"],
          birthday: row["birthday"],
          height: row["height"],
          weight: row["weight"],
          throw: row["throw"],
          hit: row["hit"],
          detail: row["detail"]
      )
    end
    self.import!(players)
    self.count - current_player_count
  end






end
