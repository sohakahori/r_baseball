require 'rails_helper'

RSpec.describe Admin::ResponsesController, type: :controller do

  let(:admin) { FactoryBot.create(:admin) }
  let!(:comment){ FactoryBot.create(:response) }


  describe  "#index" do
    context "認証済み" do
      it "200ステーテスコードをレスポンスすること" do
        sign_in admin
        get :index,
            params: {
              board_id: comment.board.id
            }
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "302ステーテスコードをレスポンスすること" do
        get :index, params: {
          board_id: comment.board.id
        }
        expect(response).to have_http_status 302
      end
    end
  end


  describe  "#index" do
    context "認証済み" do
      it "Responses(コメント)を削除できること" do
        sign_in admin
        expect {
          delete :destroy, params: {
            board_id: comment.board.id,
            id: comment.id
          }
        }.to change(Response, :count).by(-1)
        expect(response).to have_http_status 302
      end
    end

    context "認証済み" do
      it "Responses(コメント)を削除されないこと" do
        expect {
          delete :destroy, params: {
            board_id: comment.board.id,
            id: comment.id
          }
        }.to change(Response, :count).by(0)
        expect(response).to have_http_status 302
      end
    end
  end
end
