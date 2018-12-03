require 'rails_helper'

RSpec.feature "Admin::Responses", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #

  let(:admin) { FactoryBot.create(:admin) }

  feature "index", forcus: true do
    let(:user) { FactoryBot.create(:user, first_name: "名前", last_name: "苗字", nickname: "ニックネーム", email: "test@test.com") }
    let(:search_user) { FactoryBot.create(:user, first_name: "検索名前", last_name: "検索苗字", nickname: "検索ニックネーム", email: "search@search.com") }
    let!(:board) { FactoryBot.create(:board, title: "スレッド名", user: user) }

    before do
      (1..40).each do |i|
        FactoryBot.create(:response, body: "コメント#{i}", user: user, board: board)
      end
      @search_response = FactoryBot.create(:response, body: "検索コメント", user: search_user, board: board)
    end

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

      scenario "responses(コメント)一覧を返すこと(users検索)" do
        sign_in admin
        visit admin_teams_path
        click_on "スレッド管理"
        expect(page).to have_content "スレッド一覧"
        click_on "コメント一覧"
        fill_in "user_search_word", with: search_user.nickname
        click_on "検索"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content search_user.nickname
        expect(page).to have_content search_user.email
        expect(page).to have_content search_user.id
        expect(page).to have_content search_user.get_full_name
      end

      scenario "responses(コメント)一覧を返すこと(responses検索)" do
        sign_in admin
        visit admin_teams_path
        click_on "スレッド管理"
        expect(page).to have_content "スレッド一覧"
        click_on "コメント一覧"
        fill_in "user_search_word", with: search_user.nickname
        click_on "検索"
        expect(page).to have_content "検索コメント"
        expect(page).to have_content @search_response.body
        expect(page).to have_content search_user.nickname
        expect(page).to have_content search_user.email
        expect(page).to have_content search_user.id
        expect(page).to have_content search_user.get_full_name
      end
    end
  end

  feature "index", forcus: true do
    let!(:response) { FactoryBot.create(:response) }
    context "認証済み" do
      scenario "response(コメント)を削除できること" do
        sign_in admin
        visit admin_teams_path
        click_on "スレッド管理"
        expect(page).to have_content "スレッド一覧"
        click_on "コメント一覧"
        expect {
          click_on "削除"
        }.to change(Response, :count).by(-1)
        expect(page).to have_content "コメントを削除しました"
      end
    end
  end
end
