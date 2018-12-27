require 'rails_helper'

RSpec.describe "PlayersApis", type: :request do

  let(:user) { FactoryBot.create(:user) }
  let(:team) { FactoryBot.create(:team) }
  let!(:player) { FactoryBot.create(:player, name: "哲人", team: team) }
  before do

    40.times do |i|
      FactoryBot.create(:player, team: team)
    end
    @auth_headers = token_sign_in user
  end

  describe "GET /api/v1/teams/:id/player" do
    it "選手一覧を返すこと" do
      get api_v1_team_players_path(team), headers: @auth_headers
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      json = JSON.parse(response.body)
      expect(json["players"][0]["name"]).to eq "哲人"
    end
  end

  describe "GET /api/v1/teams/:id/player/:id" do
    it "選手詳細を返すこと" do
      get api_v1_team_player_path(team, player), headers: @auth_headers
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      json = JSON.parse(response.body)
      expect(json["name"]).to eq "哲人"
    end
  end

  def token_sign_in user
    return user.create_new_auth_token
  end
end
