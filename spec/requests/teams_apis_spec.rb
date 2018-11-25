require 'rails_helper'

RSpec.describe "TeamsApis", type: :request do

  let(:user) { FactoryBot.create(:user) }
  let!(:central_team) { FactoryBot.create(:team, league: 1, name: "読売ジャイアンツ") }

  before do
    12.times do |i|
      FactoryBot.create(:team, league: 2)
    end
    @auth_headers = token_sign_in user
  end

  describe "GET /api/v1/teams", force: true do
    it "球団一覧を返すこと" do

      get api_v1_teams_path, headers: @auth_headers
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json["teams"][0]["name"]).to eq "読売ジャイアンツ"
    end
  end

  describe "GET /api/v1/teams/:id", force: true do
    it "球団詳細を返すこと" do
      get api_v1_team_path(central_team), headers: @auth_headers
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json["name"]).to eq "読売ジャイアンツ"
    end
  end


  def token_sign_in user
    return user.create_new_auth_token
  end
end
