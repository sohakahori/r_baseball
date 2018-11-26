require 'rails_helper'

RSpec.describe "BoardsApis", type: :request do

  let(:user) { FactoryBot.create(:user) }
  let!(:board) { FactoryBot.create(:board, title: "テストタイトル",user: user) }
  let!(:other_board) { FactoryBot.create(:board) }
  before do
    (1..40).each do |i|
      FactoryBot.create(:board, user: user)
    end
    @headers = token_sign_in user
  end

  describe "GET /api/v1/boards" do
    it "スレッド一覧を返すこと" do
      get api_v1_boards_path, headers: @headers
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json["bords"].length).to eq 30
      expect(json["bords"][0]["title"]).to eq "テストタイトル"
    end

    it "titleで検索できること" do
      get api_v1_boards_path, headers: @headers, params: {title: 'テストタイトル'}
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json["bords"].length).to eq 1
      expect(json["bords"][0]["title"]).to eq "テストタイトル"
    end
  end

  describe "POST /api/v1/boards" do
    context "正常系" do
      it "スレッドを作成できること" do
        expect {
          post api_v1_boards_path,
               headers: @headers,
               params: {
                   board: {
                       title: "タイトル"
                   }
               }

        }.to change(Board, :count).by(1)
        expect(response).to have_http_status(200)
      end
    end

    context "異常系" do
      it "タイトルが空の時はスレッドを作成できないこと" do
        expect {
          post api_v1_boards_path,
               headers: @headers,
               params: {
                   board: {
                       title: ""
                   }
               }

        }.to change(Board, :count).by(0)

        json = JSON.parse(response.body)
        expect(json["code"]).to eq "400"
        expect(json["errors"][0]).to eq "タイトルを入力してください"
      end

      it "タイトルが30字以上の時はスレッドを作成できないこと" do
        title = "1" * 31
        expect {
          post api_v1_boards_path,
               headers: @headers,
               params: {
                   board: {
                       title: title
                   }
               }

        }.to change(Board, :count).by(0)

        json = JSON.parse(response.body)
        expect(json["code"]).to eq "400"
        expect(json["errors"][0]).to eq "タイトルは30文字以内で入力してください"
      end
    end

  end

  describe "DELETE /api/v1/boards/:id" do
    context "正常系" do
      it "スレッドを削除できること" do
        expect {
          delete api_v1_board_path(board), headers: @headers
        }.to change(Board, :count).by(-1)
        expect(response).to have_http_status(200)
      end
    end

    context "異常系" do
      it "存在しないboard_idを指定した際、エラーとなること" do
        expect {
          delete "/api/v1/boards/#{Board.last.id + 1}", headers: @headers
        }.to change(Board, :count).by(0)

        json = JSON.parse(response.body)
        expect(json["code"]).to eq "400"
      end

      it "自身が作成したスレッド(bord)以外は削除できないこと" do
        expect {
          delete api_v1_board_path(other_board), headers: @headers
        }.to change(Board, :count).by(0)

        json = JSON.parse(response.body)
        expect(json["code"]).to eq "400"
        expect(json["errors"][0]).to eq "スレッドは作成者しか削除することはできません。"
      end
    end
  end


  def token_sign_in user
    return user.create_new_auth_token
  end

end
