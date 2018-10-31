require 'rails_helper'

RSpec.feature "Players", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #

  let(:admin) { FactoryBot.create(:admin) }
  let!(:team) { FactoryBot.create(:team) }
  let!(:player) { FactoryBot.create(:player, team: team) }
  def log_in
    visit new_admin_session_path
    fill_in "メールアドレス", with: admin.email
    fill_in "パスワード", with: admin.password
    click_on "Log in"
  end

  feature "#index" do
    context "認証済み" do
      scenario "player一覧画面に遷移すること" do
        log_in
        click_on "選手一覧"
        expect(page).to have_content player.name
      end
    end
  end

  feature "#show" do
    context "認証済み" do
      scenario "player詳細画面に遷移すること" do
        log_in
        click_on "選手一覧"
        click_on "詳細"
        expect(page).to have_content player.detail
      end
    end
  end

  feature "#new" do
    context "認証済み" do
      scenario "player作成画面に遷移すること" do
        log_in
        click_on "選手一覧"
        click_on "新規作成"
        expect(page).to have_selector("form")
      end
    end
  end

  feature "#create" do
    context "認証済み" do
      scenario "playerを作成できること" do
        log_in
        click_on "選手一覧"
        click_on "新規作成"
        expect(page).to have_selector("form")
        expect {
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"

          expect(page).to have_content "選手の登録に成功しました。"
        }.to change(Player, :count).by(1)

      end

      context "バリデーション" do






        scenario "背番号が空の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "新規作成"
          fill_in "背番号", with: nil
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Noは必須です。"
        end

        scenario "背番号が文字列の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "新規作成"
          fill_in "背番号", with: '背番号'
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Noは数値で入力してください。"
        end

        scenario "nameが空の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "新規作成"
          fill_in "背番号", with: 19
          fill_in "選手名", with: nil
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Nameは必須です。"
        end

        scenario "birthdayが空の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "新規作成"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: nil
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Birthdayは必須です。"
        end

        scenario "heightが空の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "新規作成"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: nil
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Heightは必須です。"
        end

        scenario "heightが文字列の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "新規作成"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: "身長"
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Heightは数値で入力してください。"
        end

        scenario "heightが一桁の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "新規作成"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 1
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Heightは2〜3桁の範囲で入力してください。"
        end

        scenario "heightが4桁の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "新規作成"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 1234
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Heightは2〜3桁の範囲で入力してください。"
        end

        scenario "weightが空の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "新規作成"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: nil
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Weightは必須です。"
        end

        scenario "weightが文字列の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "新規作成"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: "体重"
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Weightは数値で入力してください。"
        end

        scenario "weightが一桁の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "新規作成"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 1
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Weightは2〜3桁の範囲で入力してください。"
        end

        scenario "weightが4桁の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "新規作成"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 1234
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "登録"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Weightは2〜3桁の範囲で入力してください。"
        end
      end
    end
  end

  feature "#edit" do
    context "認証済み" do
      scenario "player編集画面に遷移すること" do
        log_in
        click_on "選手一覧"
        click_on "変更"
        expect(page).to have_selector "form"
        expect(find("#player_name").value).to eq player.name
      end
    end
  end

  feature "#update" do
    context "認証済み" do
      scenario "playerを更新できること" do
        log_in
        click_on "選手一覧"
        click_on "変更"
        fill_in "背番号", with: 19
        fill_in "選手名", with: "上原浩二"
        fill_in "誕生日", with: "1889/08/30"
        select '投手', from: '守備位置'
        fill_in "身長", with: 187
        fill_in "体重", with: 87
        select "右", from: "投"
        select "左", from: "打席"
        fill_in "備考", with: "メジャー帰り"
        click_on "変更"
        expect(page).to have_content "選手の変更に成功しました。"
        expect(player.reload.name).to eq "上原浩二"
      end

      context "バリデーション" do
        scenario "背番号が空の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: nil
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Noは必須です。"
        end

        scenario "背番号が文字列の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: '背番号'
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Noは数値で入力してください。"
        end

        scenario "nameが空の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: 19
          fill_in "選手名", with: nil
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Nameは必須です。"
        end

        scenario "birthdayが空の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: nil
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Birthdayは必須です。"
        end

        scenario "heightが空の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: nil
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Heightは必須です。"
        end

        scenario "heightが文字列の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: "身長"
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Heightは数値で入力してください。"
        end

        scenario "heightが一桁の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 1
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Heightは2〜3桁の範囲で入力してください。"
        end

        scenario "heightが4桁の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 1234
          fill_in "体重", with: 87
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Heightは2〜3桁の範囲で入力してください。"
        end

        scenario "weightが空の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: nil
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Weightは必須です。"
        end

        scenario "weightが文字列の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: "体重"
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Weightは数値で入力してください。"
        end

        scenario "weightが一桁の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 1
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Weightは2〜3桁の範囲で入力してください。"
        end

        scenario "weightが4桁の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 1234
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Weightは2〜3桁の範囲で入力してください。"
        end

        scenario "weightが4桁の時バリデーションに引っかかること" do
          log_in
          click_on "選手一覧"
          click_on "変更"
          fill_in "背番号", with: 19
          fill_in "選手名", with: "上原浩二"
          fill_in "誕生日", with: "1889/08/30"
          select '投手', from: '守備位置'
          fill_in "身長", with: 187
          fill_in "体重", with: 1234
          select "右", from: "投"
          select "左", from: "打席"
          fill_in "備考", with: "メジャー帰り"
          click_on "変更"
          expect(page).to have_content "入力項目に不備があります。"
          expect(page).to have_content "Weightは2〜3桁の範囲で入力してください。"
        end
      end
    end
  end

  feature "#destroy" do
    context "認証済み" do
      scenario "playerを削除できること" do
        log_in
        click_on "選手一覧"
        expect {
          click_on "削除"
          expect(page).to have_content "選手の削除に成功しました。"
          expect(page).not_to have_content "テスト選手"
        }.to change(Player, :count).by(-1)
      end
    end
  end
end
