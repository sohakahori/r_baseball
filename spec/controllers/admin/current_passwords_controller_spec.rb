require 'rails_helper'

RSpec.describe Admin::CurrentPasswordsController, type: :controller do
  let(:admin) { FactoryBot.create(:admin) }
  describe "#new" do
    context "認証済み" do
      it "200ステータスコードを返すこと" do
        sign_in admin
        get :new
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "302ステータスコードを返すこと" do
        get :new
        expect(response).to have_http_status 302
      end
    end
  end

  describe "#create" do
    context "認証済み" do
      it "302ステータスコードを返すこと" do
        sign_in admin
        post :create, params: {
            admin: {
                current_password: "testtest",
                password: "passwordupdate",
                password_confirmation: "passwordupdate"
            }
        }
        expect(response).to have_http_status 302
      end

      it "パスワードが更新されていること" do
        sign_in admin
        post :create, params: {
            admin: {
                current_password: "testtest",
                password: "passwordupdate",
                password_confirmation: "passwordupdate"
            }
        }
        expect(admin.encrypted_password).not_to eq admin.reload.encrypted_password
      end

      it "不正な値の際は、パスワード変更画面を再表示すること" do
        sign_in admin
        post :create, params: {
            admin: {
                current_password: "testtestaaaa",
                password: "passwordupdate",
                password_confirmation: "passwordupdate"
            }
        }
        expect(response).to render_template(:new)
      end
    end

    context "未認証" do
      it "302ステータスコードを返すこと" do
        post :create, params: {
            admin: {
                current_password: "testtestaaaa",
                password: "passwordupdate",
                password_confirmation: "passwordupdate"
            }
        }
        expect(response).to have_http_status 302
      end
    end
  end
end
