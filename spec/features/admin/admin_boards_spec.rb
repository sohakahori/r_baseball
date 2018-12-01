require 'rails_helper'

RSpec.feature "Admin::Boards", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #

  before do
    (1..40).each do |i|
      FactoryBot.create(:board, title: "タイトル#{i}")
    end
  end

  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user, first_name: "検索用名前", last_name: "検索用苗字", nickname: "検索用ニックネーム", email: "search@test.com") }
  let(:board) { FactoryBot.create(:board, title: "検索用タイトル", user: user) }
  let!(:comment) { FactoryBot.create(:response, body: "検索用コメント", board: board) }


  feature "index" do
    context "認証済み" do
      scenario "boards(スレッド)一覧画面に遷移すること(ページネーション含む)" do
        sign_in admin
        visit admin_teams_path
        click_on "スレッド管理"
        save_and_open_page
        expect(page).to have_content "スレッド管理"
        puts Board.all.count
        expect(page).to have_content "タイトル30"
        expect(page).not_to have_content "タイトル31"

        click_on "2"
        expect(page).not_to have_content "タイトル30"
        expect(page).to have_content "タイトル31"
      end

      scenario "検索したboards(スレッド)一覧を返すこと(スレッド名(board.title)" do
        sign_in admin
        visit admin_teams_path
        click_on "スレッド管理"
        fill_in "title_search", with: "検索用タイトル"
        click_on "検索"
        expect(page).to have_content "検索用タイトル"
      end

      scenario "検索したboards(スレッド)一覧を返すこと(コメント(board.comments.comment_search)" do
        sign_in admin
        visit admin_teams_path
        click_on "スレッド管理"
        fill_in "comment_search", with: "検索用コメント"
        click_on "検索"
        expect(page).to have_content "検索用タイトル"
      end

      scenario "検索したboards(スレッド)一覧を返すこと(ユーザー(board.user.search_like_users)" do
        sign_in admin
        visit admin_teams_path
        click_on "スレッド管理"
        fill_in "user_search", with: "検索用苗字 検索用名前"
        click_on "検索"
        expect(page).to have_content "検索用苗字 検索用名前"
        expect(page).to have_content "検索用タイトル"
      end
    end
  end
end
