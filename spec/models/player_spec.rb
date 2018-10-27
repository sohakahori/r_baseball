require 'rails_helper'

RSpec.describe Player, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  #

  before :each do
    @team = Team.create(
        name: '読売ジャイアンツ',
        league: '1',
        stadium: '東京ドーム',
        address: '東京都渋谷区'
    )
  end
  context '入力チェック正常系' do
    it "入力値が正しい時はバリデーションに引っかからないこと" do
      player = FactoryBot.build(:player)
      expect(player).to be_valid
    end

    it "備考が未入力時の際、バリデーションに引っかからないこと" do
      player = FactoryBot.build(:player, :detail_of_nil)
      expect(player).to be_valid
    end
  end

  context '入力チェック異常系' do
    it '背番号(no)が未入力の時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :no_of_nil)
      player.valid?
      expect(player.errors[:no]).to include('は必須です。')
    end

    it '背番号(no)が数値以外(文字列)入力の時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :no_of_string)
      player.valid?
      expect(player.errors[:no]).to include('数値で入力してください。')
    end

    it '選手名(name)が未入力の時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :name_of_nil)
      player.valid?
      expect(player.errors[:name]).to include('は必須です。')
    end

    it '誕生日(birthday)が未入力の時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :birthday_of_nil)
      player.valid?
      expect(player.errors[:birthday]).to include('は必須です。')
    end

    it '守備位置(position)が未入力の時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :position_of_nil)
      player.valid?
      expect(player.errors[:position]).to include('は必須です。')
    end

    it '身長(height)が未入力の時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :height_of_nil)
      player.valid?
      expect(player.errors[:height]).to include('は必須です。')
    end

    it '身長(height)が数値以外の入力時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :height_of_string)
      player.valid?
      expect(player.errors.messages[:height]).to include('数値で入力してください。')
    end

    it '身長(height)が1桁の数値入力時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :height_of_a_digit)
      player.valid?
      expect(player.errors[:height]).to include('2〜3桁の範囲で入力してください。')
    end

    it '身長(height)が4桁の数値入力時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :height_of_four_digit)
      player.valid?
      expect(player.errors[:height]).to include('2〜3桁の範囲で入力してください。')
    end

    it '体重(weight)が数値以外の入力時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :weight_of_string)
      player.valid?
      expect(player.errors.messages[:weight]).to include('数値で入力してください。')
    end

    it '体重(weight)が1桁の数値入力時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :weight_of_a_digit)
      player.valid?
      expect(player.errors[:weight]).to include('2〜3桁の範囲で入力してください。')
    end

    it '身長(weight)が4桁の数値入力時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :weight_of_four_digit)
      player.valid?
      expect(player.errors[:weight]).to include('2〜3桁の範囲で入力してください。')
    end

    it '投(throw)が未入力の時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :throw_of_nil)
      player.valid?
      expect(player.errors[:throw]).to include('は必須です。')
    end

    it '打席(hit)が未入力の時はバリデーションに引っかかること' do
      player = FactoryBot.build(:player, :hit_of_nil)
      player.valid?
      expect(player.errors[:hit]).to include('は必須です。')
    end
  end
end
