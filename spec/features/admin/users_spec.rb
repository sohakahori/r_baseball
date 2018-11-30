require 'rails_helper'

RSpec.feature "Admin::Users", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #

  let(:admin) { FactoryBot.create(:admin) }

  feature "index" do
    context "認証済み" do
      before do
        (1..41).each do |i|
          FactoryBot.create(:user, nickname: "ニックネーム#{i}")
        end
        (1..3).each do |i|
          FactoryBot.create(:user, first_name: "名前#{i}")
        end
        (1..3).each do |i|
          FactoryBot.create(:user, last_name: "苗字#{i}")
        end
        (1..3).each do |i|
          FactoryBot.create(:user, nickname: "アダ名#{i}")
        end
        (1..3).each do |i|
          FactoryBot.create(:user, email: "user_search#{i}@test.com")
        end

        # full_name用
        FactoryBot.create(:user, first_name: "full_first_name", last_name: "full_last_name")
      end
      scenario "users(ユーザー)一覧画面に遷移すること(ページネーション含む)" do
        sign_in admin
        visit admin_teams_path
        click_on 'ユーザー管理'
        expect(page).to have_content "ユーザー一覧"
        expect(page).to have_content "苗字"
        expect(page).to have_content "名前"
        expect(page).to have_content "ニックネーム"
        expect(page).to have_content "ニックネーム30"
        expect(page).not_to have_content "ニックネーム31"
        click_on "Next"
        expect(page).to have_content "ニックネーム31"
      end

      scenario "検索結果のusers(first_name)(ユーザー)一覧をレスポンスすること" do
        sign_in admin
        visit admin_teams_path
        click_on 'ユーザー管理'
        expect(page).to have_content "ユーザー一覧"
        fill_in "search_word", with: "名前"
        click_on '検索'
        expect(page).to have_content "名前1"
        expect(page).to have_content "名前3"
        expect(page).not_to have_content "苗字1"
        expect(page).not_to have_content "アダ名2"
        expect(page).not_to have_content "user_search3@test.com"
      end

      scenario "検索結果のusers(last_name)(ユーザー)一覧をレスポンスすること" do
        sign_in admin
        visit admin_teams_path
        click_on 'ユーザー管理'
        expect(page).to have_content "ユーザー一覧"
        fill_in "search_word", with: "苗字"
        click_on '検索'
        expect(page).to have_content "苗字1"
        expect(page).to have_content "苗字3"
        expect(page).not_to have_content "名前1"
        expect(page).not_to have_content "アダ名2"
        expect(page).not_to have_content "user_search3@test.com"
      end

      scenario "検索結果のusers(nickname)(ニックネーム)一覧をレスポンスすること" do
        sign_in admin
        visit admin_teams_path
        click_on 'ユーザー管理'
        expect(page).to have_content "ユーザー一覧"
        fill_in "search_word", with: "アダ名"
        click_on '検索'
        expect(page).to have_content "アダ名1"
        expect(page).to have_content "アダ名3"
        expect(page).not_to have_content "名前1"
        expect(page).not_to have_content "苗字2"
        expect(page).not_to have_content "user_search3@test.com"
      end

      scenario "検索結果(email)(メールアドレス)のusers一覧をレスポンスすること" do
        sign_in admin
        visit admin_teams_path
        click_on 'ユーザー管理'
        expect(page).to have_content "ユーザー一覧"
        fill_in "search_word", with: "user_search"
        click_on '検索'
        expect(page).to have_content "user_search1@test.com"
        expect(page).to have_content "user_search3@test.com"
        expect(page).not_to have_content "名前1"
        expect(page).not_to have_content "苗字2"
        expect(page).not_to have_content "アダ名3"
      end

      scenario "検索結果(full_name)(苗字 名前)のusers一覧をレスポンスすること" do
        sign_in admin
        visit admin_teams_path
        click_on 'ユーザー管理'
        expect(page).to have_content "ユーザー一覧"
        fill_in "search_word", with: "full_last_name full_first_name"
        click_on '検索'
        expect(page).to have_content "full_first_name"
        expect(page).to have_content "full_last_name"
        expect(page).not_to have_content "名前1"
        expect(page).not_to have_content "苗字2"
        expect(page).not_to have_content "アダ名3"
        expect(page).not_to have_content "user_search3@test.com"
      end
    end
  end

  feature "destroy" do
    let!(:user) { FactoryBot.create(:user, nickname: "削除ユーザー") }
    context "認証済み" do
      scenario "users(ユーザー)を削除できること" do
        sign_in admin
        visit admin_teams_path
        click_on 'ユーザー管理'
        expect(page).to have_content "削除ユーザー"
        expect {
          click_on "削除"
        }.to change(User, :count).by(-1)
        expect(page).to have_content "ユーザーの削除に成功しました。"
      end
    end
  end
end
