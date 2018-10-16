class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.references :team, foreign_key: true
      t.string :no, comment: '背番号'
      t.string :name
      t.string :image
      t.integer :position, comment: '守備位置'
      t.string :birthday
      t.string :height, comment: '身長'
      t.string :weight, comment: '体重'
      t.integer :throw, comment: '効き投げ: 1 => 右, 2 => 左'
      t.integer :hit, comment: '効き打席: 1 => 右, 2 => 左, 3 => 両'
      t.text :detail, comment: '備考'
      t.timestamps
    end
  end
end
