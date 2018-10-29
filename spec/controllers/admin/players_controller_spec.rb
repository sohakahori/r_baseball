require 'rails_helper'

RSpec.describe Admin::PlayersController, type: :controller do

  before do
    @admin  = FactoryBot.create(:admin)
    @team   = FactoryBot.create(:team)
    @other_team = FactoryBot.create(:team)
    @player = FactoryBot.create(:player, team: @team, name: "テスト選手")
  end
  describe "#index" do
    context "認証済み" do
      it "200ステータスコードを返すこと" do
        sign_in @admin
        get :index,
            params: {
                team_id: @team.id
            }
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "302ステータスコードを返すこと" do
        get :index,
            params: {
                team_id: @team.id
            }
        expect(response).to have_http_status 302
      end
    end

    it "ログイン画面にリダイレクトされること" do
      get :index,
          params: {
              team_id: @team.id
          }
      expect(response).to redirect_to(new_admin_session_path)
    end
  end

  describe "#show" do
    context "認証済み" do
      it "302ステータスコードを返すこと" do
        sign_in @admin
        get :show,
            params: {
                team_id: @team.id,
                id: @player.id
            }
        expect(response).to have_http_status 200
      end

      it "不正なパラメータが送られた時、players一覧画面にレスポンスされること" do
        sign_in @admin
        get :show,
            params: {
                team_id: @other_team.id,
                id: @player.id
            }
        expect(response).to redirect_to(admin_team_players_path(@team))
      end
    end

    context "未認証" do
      it "302ステータスコードを返すこと" do
        get :show,
            params: {
                team_id: @team.id,
                id: @player.id
            }
        expect(response).to have_http_status 302
      end

      it "ログイン画面にリダイレクトされること" do
        get :show,
            params: {
                team_id: @team.id,
                id: @player.id
            }
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end

  describe "#new" do
    context "認証済み" do
      it "200ステータスコードが返ること" do
        sign_in @admin
        get :new,
            params: {
                team_id: @team.id
            }
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "302ステータスコードが返ること" do
        get :new,
            params: {
                team_id: @team.id
            }
        expect(response).to have_http_status 302
      end

      it "ログイン画面にリダイレクトされること" do
        get :new,
            params: {
                team_id: @team.id
            }
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end

  describe "#create" do
    context "認証済み" do
      it "playersテーブルにインサートされること" do
        sign_in @admin
        player_params = FactoryBot.attributes_for(:player)
        expect {
         post :create,
              params: {
                  team_id: @team.id,
                  player: player_params
              }
        }.to change(@team.players, :count).by(1)
      end
    end

    context "未認証" do
      it "302ステータスコードを返すこと" do
        player_params = FactoryBot.attributes_for(:player)
        post :create,
             params: {
                 team_id: @team.id,
                 player: player_params
             }
        expect(response).to have_http_status 302
      end

      it "ログイン画面へリダイレクトすること" do
        player_params = FactoryBot.attributes_for(:player)
        post :create,
             params: {
                 team_id: @team.id,
                 player: player_params
             }
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end

  describe "#edit" do
    context "認証済み" do
      it "200ステータスコードを返すこと" do
        sign_in @admin
        get :edit,
            params: {
                team_id: @team.id,
                id: @player.id
            }
        expect(response).to have_http_status 200
      end

      it "不正なパラメータが送られた時、players一覧画面にレスポンスされること" do
        sign_in @admin
        get :edit,
            params: {
                team_id: @other_team.id,
                id: @player.id
            }
        expect(response).to redirect_to(admin_team_players_path(@team))
      end
    end

    context "未認証" do
      it "302ステータスコードを返すこと" do
        get :edit,
            params: {
                team_id: @team.id,
                id: @player.id
            }
        expect(response).to have_http_status 302
      end

      it "ログイン画面へリダイレクトされること" do
        get :edit,
            params: {
                team_id: @team.id,
                id: @player.id
            }
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end

  describe "#update" do
    context "認証済み" do
      it "対象の値が書き換わること" do
        sign_in @admin
        player_params = FactoryBot.attributes_for(:player, name: "テスト選手更新")
        put :update,
            params: {
                team_id: @team.id,
                id: @player.id,
                player: player_params

            }
        expect(@player.reload.name).to eq "テスト選手更新"
      end

      it "不正なパラメータが送られた時、players一覧画面にレスポンスされること" do
        sign_in @admin
        player_params = FactoryBot.attributes_for(:player, name: "テスト選手更新")
        put :update,
            params: {
                team_id: @other_team.id,
                id: @player.id,
                player: player_params
            }
        expect(response).to redirect_to(admin_team_players_path(@team))
      end
    end

    context "未認証" do
      it "302ステータスコードが返ること" do
        player_params = FactoryBot.attributes_for(:player, name: "テスト選手更新")
        put :update,
            params: {
                team_id: @other_team.id,
                id: @player.id,
                player: player_params
            }
        expect(response).to have_http_status 302
      end

      it "ログイン画面にリダイレクトされること" do
        player_params = FactoryBot.attributes_for(:player, name: "テスト選手更新")
        put :update,
            params: {
                team_id: @other_team.id,
                id: @player.id,
                player: player_params
            }
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end

  describe "#destroy" do
    context "認証済み" do
      it "対象のレコードが削除されること" do
        sign_in @admin
        expect {
          delete :destroy,
                 params: {
                     team_id: @team.id,
                     id: @player.id
                 }
        }.to change(Player, :count).by(-1)
      end
    end

    context "未認証" do
      it "302ステータスコードが返ること" do
        delete :destroy,
               params: {
                   team_id: @team.id,
                   id: @player.id
               }
        expect(response).to have_http_status 302
      end

      it "ログイン画面にリダイレクトされること" do
        delete :destroy,
               params: {
                   team_id: @team.id,
                   id: @player.id
               }
        expect(response).to redirect_to(new_admin_session_path)
      end

      it "対象のレコードが削除されないこと" do
        expect {
          delete :destroy,
                 params: {
                     team_id: @team.id,
                     id: @player.id
                 }
        }.not_to change(Player, :count)
      end
    end
  end
end
