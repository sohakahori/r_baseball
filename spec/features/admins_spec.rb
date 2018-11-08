require 'rails_helper'

RSpec.feature "Admins", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #
  let(:admin) { FactoryBot.create(:admin) }

  describe "パスワード変更時(ログイン済み)" do
    scenario "ログインアカウントのパスワードを変更できること" do
      sign_in admin
      visit admin_teams_path
      click_on "パスワード変更"
      fill_in "admin[current_password]", with: "testtest"
      fill_in "admin[password]", with: "updatepassword"
      fill_in "admin[password_confirmation]", with: "updatepassword"
      click_on "変更"
      expect(page).to have_content "パスワードの変更に成功しました。"
      expect(admin.encrypted_password).not_to eq admin.reload.encrypted_password
    end

    scenario "現在のパスワードが正しくない時は、パスワードを更新されないこと" do
      sign_in admin
      visit admin_teams_path
      click_on "パスワード変更"
      fill_in "admin[current_password]", with: "aaaaaa"
      fill_in "admin[password]", with: "updatepassword"
      fill_in "admin[password_confirmation]", with: "updatepassword"
      click_on "変更"
      expect(page).to have_content "入力項目に不備があります。"
      expect(page).to have_content "現在のパスワードは不正な値です"
      expect(admin.encrypted_password).to eq admin.reload.encrypted_password
    end

    scenario "新しいパスワードと確認用パスワードが一致しない時は、パスワードを更新されないこと" do
      sign_in admin
      visit admin_teams_path
      click_on "パスワード変更"
      fill_in "admin[current_password]", with: "testtest"
      fill_in "admin[password]", with: "updatepassword1"
      fill_in "admin[password_confirmation]", with: "updatepassword2"
      click_on "変更"
      expect(page).to have_content "入力項目に不備があります。"
      expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
      expect(admin.encrypted_password).to eq admin.reload.encrypted_password
    end
  end
end
