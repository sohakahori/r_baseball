require 'rails_helper'

RSpec.feature "Admin::Users", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #

  let(:admin) { FactoryBot.create(:admin) }

  feature "index", forcus: true do
    before do
      (1..41).each do |i|
        FactoryBot.create(:user, nickname: "ニックネーム#{i}")
      end
    end
    context "認証済み" do
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
    end
  end

  feature "destroy", forcus: true do
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
