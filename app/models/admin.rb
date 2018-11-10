class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # スコープ
  scope :updated_at_desc, -> { order("updated_at DESC") }



  def full_name
    "#{self.last_name} #{self.first_name}"
  end
end
