require 'rails_helper'

RSpec.feature "Teams", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"


  let(:admin) { FactoryBot.create(:admin) }
  let!(:team) { FactoryBot.create(:team) }

  def log_in
    visit new_admin_session_path
    fill_in "メールアドレス", with: admin.email
    fill_in "パスワード", with: admin.password
    click_on "Log in"
  end

  feature "#index" do
    context "認証済み" do
      scenario "ログイン後、teams一覧画面に遷移すること" do
        log_in
        expect(page).to have_content "ログインしました。"
        expect(page).to have_content team.name
      end
    end
  end

  feature "#edit" do
    context "認証済み" do
      scenario "編集画面に遷移すること" do
        log_in
        click_on "編集"
        expect(page).to have_content "変更"
        expect(find("#team_name").value).to eq team.name
      end
    end
  end

  feature "#update" do
    context "認証済み" do
      scenario "teamが更新できること" do
        log_in
        click_on "編集"
        fill_in "球団名", with: "更新チーム"
        click_on "変更"
        expect(page).to have_content "球団の変更に成功しました。"
        expect(page).to have_content "更新チーム"
        expect(team.reload.name).to eq "更新チーム"
      end

      context "バリデーション" do
        scenario "nameが空の時、バリデーションに引っかかること" do
          log_in
          click_on "編集"
          fill_in "球団名", with: nil
          select 'セントラル', from: 'リーグ'
          fill_in "スタジアム", with: "名古屋ドーム"
          fill_in "住所", with: "東京都渋谷区"
          click_on "変更"
          expect(page).to have_content "Nameは必須です。"
        end

        scenario "stadiumが空の時、バリデーションに引っかかること" do
          log_in
          click_on "編集"
          fill_in "球団名", with: "新規作成チーム"
          select 'セントラル', from: 'リーグ'
          fill_in "スタジアム", with: nil
          fill_in "住所", with: "東京都渋谷区"
          click_on "変更"
          expect(page).to have_content "Stadiumは必須です。"
        end

        scenario "addressが空の時、バリデーションに引っかかること" do
          log_in
          click_on "編集"
          fill_in "球団名", with: "新規作成チーム"
          select 'セントラル', from: 'リーグ'
          fill_in "スタジアム", with: "名古屋ドーム"
          fill_in "住所", with: nil
          click_on "変更"
          expect(page).to have_content "Addressは必須です。"
        end

      end
    end
  end

  feature "#new" do
    context "認証済み" do
      scenario "登録ページに遷移すること" do
        log_in
        click_on "新規作成"
        expect(page).to have_selector 'form'
      end
    end
  end


  feature "#create" do
    context "バリデーション" do
      scenario "nameが空の時、バリデーションに引っかかること" do
        log_in
        click_on "新規作成"
        fill_in "球団名", with: nil
        select 'セントラル', from: 'リーグ'
        fill_in "スタジアム", with: "名古屋ドーム"
        fill_in "住所", with: "東京都渋谷区"
        click_on "登録"
        expect(page).to have_content "Nameは必須です。"
      end

      scenario "stadiumが空の時、バリデーションに引っかかること" do
        log_in
        click_on "新規作成"
        fill_in "球団名", with: "新規作成チーム"
        select 'セントラル', from: 'リーグ'
        fill_in "スタジアム", with: nil
        fill_in "住所", with: "東京都渋谷区"
        click_on "登録"
        expect(page).to have_content "Stadiumは必須です。"
      end

      scenario "addressが空の時、バリデーションに引っかかること" do
        log_in
        click_on "新規作成"
        fill_in "球団名", with: "新規作成チーム"
        select 'セントラル', from: 'リーグ'
        fill_in "スタジアム", with: "名古屋ドーム"
        fill_in "住所", with: nil
        click_on "登録"
        expect(page).to have_content "Addressは必須です。"
      end

    end

    context "認証済み" do
      scenario "teamを作成できること" do
        log_in
        click_on "新規作成"

        expect {
          fill_in "球団名", with: "新規作成チーム"
          select 'セントラル', from: 'リーグ'
          fill_in "スタジアム", with: "名古屋ドーム"
          fill_in "住所", with: "東京都渋谷区"
          click_on "登録"

          expect(page).to have_content "球団の登録に成功しました。"
          expect(page).to have_content "新規作成チーム"
        }.to change(Team, :count).by(1)
      end
    end
  end


  feature "#destroy" do
    context "認証済み" do
      scenario "teamを削除できること" do
        log_in
        expect {
          click_on "削除"
          expect(page).to have_content "球団の削除に成功しました。"
          expect(page).not_to have_content "テスト住所"
        }.to change(Team, :count).by(-1)
      end
    end
  end

end
