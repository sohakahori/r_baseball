require 'rails_helper'

RSpec.describe Admin::AdminsController, type: :controller do
  let(:admin) { FactoryBot.create(:admin) }
  let!(:admin2) { FactoryBot.create(:admin, first_name: "テスト") }

  describe '# index' do
    it '200ステータスコードを返すこと' do
      sign_in admin
      get :index
      expect(response.status).to eq 200
    end

    it '302ステータスコードを返すこと(未認証時)' do
      get :index
      expect(response.status).to eq 302
    end
  end

  describe '# new' do
    it '200ステータスコードを返すこと' do
      sign_in admin
      get :new
      expect(response.status).to eq 200
    end

    it '302ステータスコードを返すこと(未認証時)' do
      get :new
      expect(response.status).to eq 302
    end
  end

  describe '# create' do
    before do
      @admin_params = FactoryBot.attributes_for(:admin)
    end


    it '302ステータスコードを返すこと(create成功時)' do
      sign_in admin
      post :create,
           params: {
               admin: @admin_params
           }
      expect(response.status).to eq 302
    end

    it 'レコードが作成されること' do
      sign_in admin
      expect {
        post :create,
             params: {
              admin: @admin_params
             }
      }.to change(Admin, :count).by(1)
    end

    it '302ステータスコードを返すこと(未認証時)' do
      post :create,
           params: {
               admin: @admin_params
           }
      expect(response.status).to eq 302
    end
  end

  describe '# edit' do
    it '200ステータスコードを返すこと' do
      sign_in admin
      get :edit,
          params: {
            id: admin2.id
          }
      expect(response.status).to eq 200
    end

    it '302ステータスコードを返すこと(未認証時)' do
      get :new
      get :edit,
          params: {
              id: admin2.id
          }
    end
  end


  describe "# update" do
    before do
      @admin_params = FactoryBot.attributes_for(:admin, first_name: "テストfirst_name", last_name: 'テストlast_name')
    end

    it '302ステータスコードを返すこと(update成功時)' do
      sign_in admin
      put :update,
           params: {
               id: admin2.id,
               admin: @admin_params
           }
      expect(response.status).to eq 302
    end

    it 'レコードが更新されること' do
      sign_in admin
      put :update,
           params: {
               id: admin2.id,
               admin: @admin_params
           }
      expect(admin2.reload.first_name).to eq "テストfirst_name"
    end

    it '302ステータスコードを返すこと(未認証時)' do
      put :update,
          params: {
              id: admin2.id,
              admin: @admin_params
          }
      expect(response.status).to eq 302
    end
  end
  
  describe "# destroy" do
    it '302ステータスコードを返すこと(destroy成功時)' do
      sign_in admin
      delete :destroy,
          params: {
              id: admin2.id,
          }
      expect(response.status).to eq 302
    end

    it '対象レコードが削除されていること' do
      sign_in admin
      expect {
        delete :destroy,
               params: {
                   id: admin2.id,
               }
      }.to change(Admin, :count).by(-1)
    end

    it '302ステータスコードを返すこと(未認証時)' do
      delete :destroy,
             params: {
                 id: admin2.id,
             }
      expect(response.status).to eq 302
    end

  end
end
