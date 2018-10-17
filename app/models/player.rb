class Player < ApplicationRecord

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

  
end
