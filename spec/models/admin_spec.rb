require 'rails_helper'

RSpec.describe Admin, type: :model do

  context '入力チェック正常系' do
    it "入力値が正しい時はバリデーションに引っかからないこと" do
      admin = FactoryBot.build(:admin)
      expect(admin).to be_valid
    end
  end

  context '入力チェック異常系' do
    it 'first_nameが未入力の時はバリデーションに引っかかること' do
      admin = FactoryBot.build(:admin, first_name: nil)
      admin.valid?
      puts admin
      expect(admin.errors[:first_name]).to include('は必須です。')
    end

    it 'last_nameが未入力の時はバリデーションに引っかかること' do
      admin = FactoryBot.build(:admin, last_name: nil)
      admin.valid?
      puts admin
      expect(admin.errors[:last_name]).to include('は必須です。')
    end

    it 'roleが未入力の時はバリデーションに引っかかること' do
      admin = FactoryBot.build(:admin, role: nil)
      admin.valid?
      expect(admin.errors[:role]).to include('は必須です。')
    end

    it 'メールアドレスが不正な形式時バリデーションに引っかかること' do
      admin = FactoryBot.build(:admin, email: '田中太郎')
      admin.valid?
      expect(admin.errors[:email]).to include('はメールアドレスを入力してください。')
    end

    # it 'メールアドレスが存在する時はバリデーションに引っかかること' do
    #   admin1 = FactoryBot.build(:admin, email: 'test@test.com')
    #   admin2 = FactoryBot.build(:admin, email: 'test@test.com')
    #   admin2.valid?
    #   expect(admin2.errors[:email]).to include('メールアドレスはすでに存在します')
    # end

  end
end
