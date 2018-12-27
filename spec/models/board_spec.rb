require 'rails_helper'

RSpec.describe Board, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  #

  context '入力チェック正常系' do
    it "入力値が正しい時はバリデーションに引っかからないこと" do
      board = FactoryBot.build(:board)
      expect(board).to be_valid
    end

    it 'タイトル(title)が30文字の時はバリデーションに引っかからないこと' do
      board = FactoryBot.build(:board, title: "a" * 30)
      expect(board).to be_valid
    end
  end

  context '入力チェック異常系' do
    it 'タイトル(title)が未入力の時はバリデーションに引っかかること' do
      board = FactoryBot.build(:board, title: nil)
      board.valid?
      expect(board.errors.messages[:title]).to include('を入力してください')
    end

    it 'タイトル(title)が31文字以上の時はバリデーションに引っかかること' do
      board = FactoryBot.build(:board, title: "a" * 31)
      board.valid?
      expect(board.errors.messages[:title]).to include('は30文字以内で入力してください')
    end
  end
end
