require 'rails_helper'

RSpec.describe Team, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  #
  context '入力チェック正常系' do
    it "入力値が正しい時はバリデーションに引っかからないこと" do
      team = FactoryBot.build(:team)
      team.valid?
      expect(team).to be_valid
    end
  end

  context '入力チェック異常系' do
    it '球団名(name)が未入力の時はバリデーションに引っかかること' do
      team = FactoryBot.build(:team, :name_of_nil)
      team.valid?
      expect(team.errors.messages[:name]).to include('は必須です。')
    end

    it 'リーグ(league)が未入力の時はバリデーションに引っかかること' do
      team = FactoryBot.build(:team, :league_of_nil)
      team.valid?
      expect(team.errors.messages[:league]).to include('は必須です。')
    end

    it 'スタジアム(stadium)が未入力の時はバリデーションに引っかかること' do
      team = FactoryBot.build(:team, :stadium_of_nil)
      team.valid?
      expect(team.errors.messages[:stadium]).to include('は必須です。')
    end

    it '住所(address)が未入力の時はバリデーションに引っかかること' do
      team = FactoryBot.build(:team, :address_of_nil)
      team.valid?
      expect(team.errors.messages[:address]).to include('は必須です。')
    end
  end

end