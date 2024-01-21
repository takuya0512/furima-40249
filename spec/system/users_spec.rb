require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    # テストに必要なユーザーオブジェクトを生成
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページにアクセスし、新規登録リンクが表示されていることを確認
      visit root_path
      expect(page).to have_content('新規登録')

      # 新規登録ページにアクセス
      visit new_user_registration_path

      # フォームに正しい情報を入力
      fill_in 'user[nickname]', with: @user.nickname
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      fill_in 'user[last_name]', with: @user.last_name
      fill_in 'user[first_name]', with: @user.first_name
      fill_in 'user[last_name_kana]', with: @user.last_name_kana
      fill_in 'user[first_name_kana]', with: @user.first_name_kana
      select '1930', from: 'user_birthdate_1i'
      select '1', from: 'user_birthdate_2i'
      select '17', from: 'user_birthdate_3i'

      # 登録ボタンをクリックしてユーザーモデルのカウントが1増えることを確認
      expect {
        find('input[name="commit"]').click
        sleep 1  # クリック後にDOMが変更されるまで待機
      }.to change { User.count }.by(1)

      # トップページにリダイレクトされ、ログアウトボタンが表示されていることを確認
      expect(current_path).to eq root_path
      expect(find('.logout').hover).to have_content('ログアウト')

      # 新規登録やログインボタンが表示されていないことを確認
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '空の情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページにアクセスし、新規登録リンクが表示されていることを確認
      visit root_path
      expect(page).to have_content('新規登録')

      # 新規登録ページにアクセス
      visit new_user_registration_path

      # フォームに空の情報を入力
      fill_in 'user[nickname]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      fill_in 'user[password_confirmation]', with: ''
      fill_in 'user[last_name]', with: ''
      fill_in 'user[first_name]', with: ''
      fill_in 'user[last_name_kana]', with: ''
      fill_in 'user[first_name_kana]', with: ''

      # 登録ボタンをクリックしてユーザーモデルのカウントが増えないことを確認
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)

      # 新規登録ページに戻されることを確認
      expect(current_path).to eq new_user_registration_path
    end

    it '制約外の情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページにアクセスし、新規登録リンクが表示されていることを確認
      visit root_path
      expect(page).to have_content('新規登録')

      # 新規登録ページにアクセス
      visit new_user_registration_path

      # フォームに制約外の情報を入力
      fill_in 'user[email]', with: '＠なし'
      fill_in 'user[password]', with: '漢字'
      fill_in 'user[password_confirmation]', with: '漢字'
      fill_in 'user[last_name]', with: 'hankaku'
      fill_in 'user[first_name]', with: 'hankaku'
      fill_in 'user[last_name_kana]', with: 'ひらがな'
      fill_in 'user[first_name_kana]', with: 'ひらがな'

      # 登録ボタンをクリックしてユーザーモデルのカウントが増えないことを確認
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)

      # 新規登録ページに戻されることを確認
      expect(current_path).to eq '/users/sign_up'
    end
  end
end
