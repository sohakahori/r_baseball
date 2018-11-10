# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Team.create(name: '読売ジャイアンツ', main_image: nil, stadium: Faker::Address.street_name, address: Faker::Address.full_address, league: 1)
Team.create(name: '広島東洋カープ', main_image: nil, stadium: Faker::Address.street_name, address: Faker::Address.full_address, league: 1)
Team.create(name: '阪神タイガース', main_image: nil, stadium: Faker::Address.street_name, address: Faker::Address.full_address, league: 1)
Team.create(name: '中日ドラゴンズ', main_image: nil, stadium: Faker::Address.street_name, address: Faker::Address.full_address, league: 1)
Team.create(name: '横浜ベイスターズ', main_image: nil, stadium: Faker::Address.street_name, address: Faker::Address.full_address, league: 1)
Team.create(name: '東京ヤクルトスワローズ', main_image: nil, stadium: Faker::Address.street_name, address: Faker::Address.full_address, league: 1)
Team.create(name: '福岡ソフトバンクホークス', main_image: nil, stadium: Faker::Address.street_name, address: Faker::Address.full_address, league: 2)
Team.create(name: '千葉ロッテマリーンズ', main_image: nil, stadium: Faker::Address.street_name, address: Faker::Address.full_address, league: 2)
Team.create(name: 'オリックスバッファローズ', main_image: nil, stadium: Faker::Address.street_name, address: Faker::Address.full_address, league: 2)
Team.create(name: '西武ライオンズ', main_image: nil, stadium: Faker::Address.street_name, address: Faker::Address.full_address, league: 2)
Team.create(name: '北海道日本ハムファイターズ', main_image: nil, stadium: Faker::Address.street_name, address: Faker::Address.full_address, league: 2)
Team.create(name: '東北楽天ゴールデンイーグル', main_image: nil, stadium: Faker::Address.street_name, address: Faker::Address.full_address, league: 2)

100.times do
  Player.create(team_id: rand(1..12), no: rand(100), name: Faker::Name.name, position: rand(1..9), birthday: '1988.02.08', height: rand(160..220), weight: rand(50..120), throw: rand(1..2), hit: rand(1..3))
end

(1..20).each do |i|
  Admin.create(email: Faker::Internet.email, password: "testtest", role: 2, first_name: "名前#{i}", last_name: "苗字#{i}")
end