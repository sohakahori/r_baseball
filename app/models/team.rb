class Team < ApplicationRecord

  # スコープ
  scope :order_league, -> { order(:league) }

  def get_league_name
    self.league == '1' ? 'セントラル' : 'パフィシック'
  end
end
