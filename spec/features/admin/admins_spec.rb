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
    let!(:search_admin) { FactoryBot.create(:admin, first_name: "検索名前", last_name: "検索苗字", email: "search@search.com") }

    scenario "管理者の一覧が表示されること(ページング含む)" do
      sign_in admin
      visit admin_admins_path
      # 指定の管理者一覧が表示されていること(15件 更新日時降順、id降順)
      expect(page).to have_content "8奥田 8花子"
      expect(page).not_to have_content "7奥田 花子"
      click_on "Next"
      expect(page).to have_content "7奥田 7花子"
      expect(page).not_to have_content "8奥田 8花子"
    end

    scenario "管理者の一覧が表示されること(name検索)" do
      sign_in admin
      visit admin_admins_path
      fill_in "search_word", with: "#{search_admin.last_name} #{search_admin.first_name}"
      click_on "検索"
      expect(page).to have_content "検索名前"
      expect(page).to have_content "検索名前"
      expect(page).to have_content "search@search.com"
    end

    scenario "管理者の一覧が表示されること(email検索)" do
      sign_in admin
      visit admin_admins_path
      fill_in "search_word", with: search_admin.email
      click_on "検索"
      expect(page).to have_content "検索名前"
      expect(page).to have_content "検索名前"
      expect(page).to have_content "search@search.com"
    end
  end

  describe "管理者作成" do
    scenario "管理者が作成できること" do
      sign_in admin
      visit admin_admins_path
      click_on "新規作成"
      expect(page).to have_content "苗字"
      expect(page).to have_content "名前"
      # expect(page).to have_content "登録"
      expect {
        fill_in "苗字", with: "テスト苗字"
        fill_in "名前", with: "テスト名前"
        fill_in "メールアドレス", with: "spec@test.com"
        select 'スーパー', from: '権限'
        fill_in "パスワード", with: "testtest"
        fill_in "確認用パスワード", with: "testtest"
        click_on "登録"
      }.to change(Admin, :count).by(1)

      expect(page).to have_content "管理者の登録に成功しました。"
      expect(Admin.last.email).to eq "spec@test.com"
      expect(page).to have_content "テスト苗字 テスト名前"
      expect(page).to have_content "spec@test.com"
    end

    scenario "入力不備時エラー処理となること" do
      sign_in admin
      visit admin_admins_path
      click_on "新規作成"
      expect(page).to have_content "苗字"
      expect(page).to have_content "名前"
      # expect(page).to have_content "登録"
      expect {
        fill_in "苗字", with: nil
        fill_in "名前", with: nil
        fill_in "メールアドレス", with: nil
        select 'スーパー', from: '権限'
        fill_in "パスワード", with: nil
        fill_in "確認用パスワード", with: nil
        click_on "登録"
      }.to change(Admin, :count).by(0)
      expect(page).to have_content "入力項目に不備があります。"
      expect(page).to have_content "メールアドレスを入力してください"
      expect(page).to have_content "苗字は必須です。"
      expect(page).to have_content "名前は必須です。"
    end
  end

  describe "管理者編集" do
    let(:edit_admin) { FactoryBot.create(:admin, first_name: "勇人", last_name: "坂本", email: "sakamoto@kyozin.com", role: '2', password: "hayato") }
    scenario "管理者を編集できること" do
      sign_in admin
      visit edit_admin_admin_path(edit_admin)
      fill_in "苗字", with: "亀井"
      fill_in "名前", with: "義之"
      fill_in "メールアドレス", with: "kamei@kyozin.com"
      select 'スーパー', from: '権限'
      click_on "変更"
      expect(edit_admin.reload.first_name).to eq "義之"
      expect(edit_admin.reload.last_name).to eq "亀井"
      expect(edit_admin.reload.email).to eq "kamei@kyozin.com"
      expect(page).to have_content "管理者の変更に成功しました。"
      expect(page).to have_content "亀井 義之"
      expect(page).to have_content "kamei@kyozin.com"
    end

    scenario "不正な入力値の時はバリデーションで弾かれること" do
      sign_in admin
      visit edit_admin_admin_path(edit_admin)
      expect {
        fill_in "苗字", with: nil
        fill_in "名前", with: nil
        fill_in "メールアドレス", with: nil
        click_on "変更"
      }.to change(Admin, :count).by(0)
      expect(page).to have_content "メールアドレスを入力してください"
      expect(page).to have_content "メールアドレスはメールアドレスを入力してください。"
      expect(page).to have_content "名前は必須です。"
      expect(page).to have_content "苗字は必須です。"
      expect(page).to have_content "入力項目に不備があります。"
    end
  end

  describe "管理者削除" do
    scenario "管理者を削除できること" do
      sign_in admin
      visit admin_admins_path
      expect {
        page.first(".btn-danger").click
      }.to change(Admin, :count).by(-1)
      expect(page).to have_content "管理者の削除に成功しました。"
    end
  end
end
