require 'rails_helper'

RSpec.feature "Admins", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #
  let(:admin) { FactoryBot.create(:admin, first_name: "太郎", last_name: "山田") }

  (1..20).each do|i|
    let!("other_admin#{i}".to_sym) { FactoryBot.create(:admin, first_name: "#{i}花子", last_name: "#{i}奥田") }
  end

  describe "パスワード変更" do
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

  describe "管理者管理" do
    scenario "管理者の一覧が表示されること(ページング含む)" do
      sign_in admin
      visit admin_admins_path
      # 指定の管理者一覧が表示されていること(15件 更新日時降順)
      expect(page).to have_content "15奥田 15花子"
      expect(page).not_to have_content "15奥田 16花子"
      click_on "Next"
      expect(page).to have_content "16奥田 16花子"
      expect(page).not_to have_content "15奥田 15花子"
    end
  end

  describe "管理者作成" do
    scenario "管理者が作成できること", forcus: true do
      sign_in admin
      visit admin_admins_path
      click_on "新規作成"
      expect(page).to have_content "苗字"
      expect(page).to have_content "名前"
      # expect(page).to have_content "登録"
      fill_in "苗字", with: "テスト苗字"
      fill_in "名前", with: "テスト名前"
      fill_in "メールアドレス", with: "spec@test.com"
      select 'スーパー', from: '権限'
      fill_in "パスワード", with: "testtest"
      fill_in "確認用パスワード", with: "testtest"
      click_on "登録"
      expect(page).to have_content "管理者の登録に成功しました。"
      expect(page).to have_content "テスト苗字 テスト名前"
      expect(page).to have_content "spec@test.com"
    end
  end
end
