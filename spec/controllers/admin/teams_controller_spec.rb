require 'rails_helper'

RSpec.describe Admin::TeamsController, type: :controller do
  
  let(:admin) { FactoryBot.create(:admin) }
  let(:team) { FactoryBot.create(:team, name: "テストチーム") }
  
  describe "#index" do
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

  describe "# new" do
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

      it "ログインページにリダイレクトされること" do
        get :new
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end

  describe "# create" do
    context "認証済み" do
      it "teamsテーブルにinsertできること" do
        sign_in admin
        team_params = FactoryBot.attributes_for(:team)
        expect {
          post :create,
               params: {
                   team: team_params
               }
        }.to change(Team, :count).by(1)

      end
    end

    context "未認証" do
      it "302ステータスコードを返すこと" do
        team_params = FactoryBot.attributes_for(:team)
        post :create,
             params: {
                 team: team_params
             }
        expect(response).to have_http_status 302
      end

      it "ログインページにリダイレクトされること" do
        team_params = FactoryBot.attributes_for(:team)
        post :create,
             params: {
                 team: team_params
             }
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "# edit" do
    context "認証済み" do
      it "200ステータスコードを返すこと" do
        sign_in admin
        get :edit,
            params: {
                id: team.id
            }
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "302ステータスコードを返すこと" do
        get :edit,
            params: {
                id: team.id
            }
        expect(response).to have_http_status 302
      end

      it "ログイン画面へリダイレクトされること" do
        get :edit,
            params: {
                id: team.id
            }
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "#update" do
    context "認証済み" do
      it "対象のレコードが更新されること" do
        team_params = FactoryBot.attributes_for(:team, name: "テストチーム更新")
        sign_in admin
        put :update,
            params: {
                id: team.id,
                team: team_params
            }
        expect(team.reload.name).to eq "テストチーム更新"
      end
    end

    context "未認証" do
      it "対象のレコードが更新されないこと" do
        team_params = FactoryBot.attributes_for(:team, name: "テストチーム更新")
        put :update,
            params: {
                id: team.id,
                team: team_params
            }
        expect(team.reload.name).not_to eq "テストチーム更新"
      end

      it "302ステータスコードが返ること" do
        team_params = FactoryBot.attributes_for(:team, name: "テストチーム更新")
        sign_in admin
        put :update,
            params: {
                id: team.id,
                team: team_params
            }
        expect(response).to have_http_status 302
      end

      it "ログインページにリダイレクトされること" do
        team_params = FactoryBot.attributes_for(:team, name: "テストチーム更新")
        put :update,
            params: {
                id: team.id,
                team: team_params
            }
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:team) { FactoryBot.create(:team, name: "テストチーム") }
    context "認証済み" do
      it "対象のレコードが削除されること" do
        sign_in admin
        expect {
          delete :destroy,
                 params: {
              id: team.id
            }
        }.to change(Team, :count).by(-1)
      end
    end

    context "未認証" do
      it "対象のレコードが削除されないこと" do
        expect {
          delete :destroy,
                 params: {
                     id: team.id
                 }
        }.not_to change(Team, :count)
      end

      it "302ステータスコードを返すこと" do
        delete :destroy,
               params: {
                   id: team.id
               }
        expect(response).to have_http_status 302
      end

      it "ログイン画面へリダイレクトされること" do
        delete :destroy,
               params: {
                   id: team.id
               }
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

end

