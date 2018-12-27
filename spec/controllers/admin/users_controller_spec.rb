require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do


  let(:admin) { FactoryBot.create(:admin) }


  describe  "#index" do
    context "認証済み" do
      it "200ステータスコードを返すこと" do
        sign_in admin
        get :index
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "302ステータスコードを返すこと" do
        get :index
        expect(response).to have_http_status 302
      end

      it "ログインページにリダイレクトされること" do
        get :index
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end

  describe  "#destroy" do
    let!(:user) { FactoryBot.create(:user) }
    context "認証済み" do
      it "200ステータスコードを返すこと" do
        sign_in admin
        expect {
          delete :destroy,
                 params: {
                   id: user.id
                 }
        }.to change(User, :count).by(-1)
      end
    end

    context "未認証" do
      it "302ステータスコードを返すこと" do
        expect {
          delete :destroy,
                 params: {
                   id: user.id
                 }
        }.to change(User, :count).by(0)
        expect(response).to have_http_status 302
      end

      it "ログインページにリダイレクトされること" do
        expect {
          delete :destroy,
                 params: {
                   id: user.id
                 }
        }.to change(User, :count).by(0)
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end
end
