class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :main_image
      t.string :stadium, null: false
      t.string :address, null: false
      t.string :league, null: false, comment: '1: セリーグ、2: パリーグ'
      t.timestamps
    end
  end
end
