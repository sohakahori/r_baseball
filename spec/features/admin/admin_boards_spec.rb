require 'rails_helper'

RSpec.feature "Admin::Boards", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #

  let(:admin) { FactoryBot.create(:admin) }
  before do
    (1..40).each do |i|
      FactoryBot.create(:board, title: "タイトル#{i}")
    end
  end

  feature "index", forcus: true do
    context "認証済み" do
      scenario "boards(スレッド)一覧画面に遷移すること(ページネーション含む)" do
        sign_in admin
        visit admin_teams_path
        click_on "スレッド管理"
        expect(page).to have_content "スレッド管理"
        expect(page).to have_content "タイトル30"
        expect(page).not_to have_content "タイトル31"

        click_on "2"
        expect(page).not_to have_content "タイトル30"
        expect(page).to have_content "タイトル31"
      end
    end
  end
end
