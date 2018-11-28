require 'rails_helper'

RSpec.describe Response, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  #
  context "入力チェック正常系" do
    it "入力値が正しい時はバリデーションに引っかからないこと" do
      response = FactoryBot.build(:response)
      expect(response).to be_valid
    end
  end

  context "入力チェック異常系" do
    it "コメント(body)が空の時はバリデーションに引っかかること" do
      response = FactoryBot.build(:response, body: nil)
      response.valid?
      expect(response.errors.messages[:body]).to include("を入力してください")
    end
  end
end
