require 'rails_helper'

RSpec.describe "ResponsesApis", type: :request do

  let(:board) { FactoryBot.create(:board) }
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  before do
    @headers = token_sign_in user
  end


  describe "GET /api/board/:board_id/responses" do

    before do
      (1..10).each do |i|
        FactoryBot.create(:response, board: board)
      end
      FactoryBot.create(:response, body: "スレッドコメント1", board: board, user: user)
    end

    it "コメント一覧を返すこと" do
      get api_v1_board_responses_path(board), headers: @headers
      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      responses_length = json["responses"].length
      expect(responses_length).to eq 11
      expect(json["responses"][responses_length - 1]["body"]).to eq "スレッドコメント1"
      expect(json["responses"][responses_length - 1]["user"]["id"]).to eq user.id
    end
  end

  describe "POST /api/board/:board_id/responses" do
    context "正常系" do
      it "response(コメント)を登録できること" do
        post api_v1_board_responses_path(board),
             headers: @headers,
             params: {
                 response: {
                     body: "コメント追加"
                 }
             }
        expect(response).to have_http_status(200)

        json = JSON.parse(response.body)
        expect(json["status"]).to eq "success"
        expect(json["response"]["body"]).to eq "コメント追加"
      end
    end

    context "異常系" do
      it "body(コメント)が空の時はresponseを作成できないこと" do
        expect {
          post api_v1_board_responses_path(board),
             headers: @headers,
             params: {
               response: {
                body: nil
               }
             }
        }.to change(Response, :count).by(0)

        json = JSON.parse(response.body)
        expect(json["status"]).to eq "error"
        expect(json["errors"]["full_messages"]).to include("コメントを入力してください")
      end
    end
  end

  describe "DELETE /api/v1/boards/:id/responses/:id" do
    before do
      @response = FactoryBot.create(:response, body: "スレッドコメント1", board: board, user: user)
      @other_response = FactoryBot.create(:response, body: "スレッドコメント2", board: board, user: other_user)
    end

    context "正常系" do
      it "response(コメント)を削除できること" do
        expect {
          delete api_v1_board_response_path(board, @response), headers: @headers
        }.to change(Response, :count).by(-1)

      end
    end

    context "異常系" do
      it "自身が作成したスレッド(responses)以外は削除できないこと" do
        expect {
          delete api_v1_board_response_path(board, @other_response), headers: @headers
        }.to change(Response, :count).by(0)

        json = JSON.parse(response.body)
        expect(json["status"]).to eq "error"
        expect(json["errors"]).to include("コメントは作成者しか削除することはできません。")
      end
    end
  end

  def token_sign_in user
    return user.create_new_auth_token
  end
end
