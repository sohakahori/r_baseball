require 'rails_helper'

RSpec.feature "Admin::Responses", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #

  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user, first_name: "名前", last_name: "苗字", nickname: "ニックネーム", email: "test@test.com") }
  let!(:board) { FactoryBot.create(:board, title: "スレッド名", user: user) }
  before do
    (1..40).each do |i|
      FactoryBot.create(:response, body: "コメント#{i}", user: user, board: board)
    end
  end

  feature "index", forcus: true do
    context "認証済み" do
      scenario "responses(コメント)一覧を返すこと(ページネーションを含む)" do
        sign_in admin
        visit admin_teams_path
        click_on "スレッド管理"
        expect(page).to have_content "スレッド一覧"
        click_on "コメント一覧"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content "コメント30"
        expect(page).not_to have_content "コメント31"
        expect(page).to have_content "苗字 名前"
        click_on "2"
        expect(page).to have_content "コメント31"
        expect(page).not_to have_content "コメント30"
      end
    end
  end
end
