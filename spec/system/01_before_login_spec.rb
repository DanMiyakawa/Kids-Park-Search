# frozen_string_literal: true

require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ログインリンクが表示される: 左上から3番目のリンクが「ログイン」である' do
        log_in_link = find_all('a')[3].native.inner_text
        expect(log_in_link).to match(/ログイン/i)
      end
      it '新規登録リンクが表示される: 左上から3番目のリンクが「新規登録」である' do
        sign_up_link = find_all('a')[2].native.inner_text
        expect(sign_up_link).to match(/新規登録/i)
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it '遊び場一覧リンクが表示される: 左上から1番目のリンクが「遊び場一覧」である' do
        parks_link = find_all('a')[1].native.inner_text
        expect(parks_link).to match(/遊び場一覧/i)
      end
      it '新規登録リンクが表示される: 左上から2番目のリンクが「新規登録」である' do
        signup_link = find_all('a')[2].native.inner_text
        expect(signup_link).to match(/新規登録/i)
      end
      it 'ログインリンクが表示される: 左上から3番目のリンクが「ログイン」である' do
        login_link = find_all('a')[3].native.inner_text
        expect(login_link).to match(/ログイン/i)
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it '遊び場一覧を押すと、遊び場一覧画面に遷移する' do
        parks_link = find_all('a')[1].native.inner_text
        parks_link = parks_link.delete(' ')
        parks_link.gsub!(/\n/, '')
        click_link parks_link
        is_expected.to eq '/parks'
      end
      it '新規登録を押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[2].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link
        is_expected.to eq '/customers/sign_up'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[3].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq '/customers/sign_in'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_customer_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_up'
      end
      it '「新規会員登録」と表示される' do
        expect(page).to have_content '新規会員登録'
      end
      it 'nicknameフォームが表示される' do
        expect(page).to have_field 'customer[nickname]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'customer[password_confirmation]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'customer[nickname]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[password]', with: 'password'
        fill_in 'customer[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(Customer.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、トップ画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/'
      end
    end
  end

  describe 'ユーザログイン' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
      it 'nicknameフォームは表示されない' do
        expect(page).not_to have_field 'customer[nickname]'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、トップ画面になっている' do
        expect(current_path).to eq '/'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'customer[email]', with: ''
        fill_in 'customer[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/customers/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it 'お気に入りリンクが表示される: 左上から1番目のリンクが「お気に入り」である' do
        favorite_link = find_all('a')[1].native.inner_text
        expect(favorite_link).to match(/お気に入り/i)
      end
      it '遊び場一覧リンクが表示される: 左上から2番目のリンクが「遊び場一覧」である' do
        parks_link = find_all('a')[2].native.inner_text
        expect(parks_link).to match(/遊び場一覧/i)
      end
      it '遊び場投稿リンクが表示される: 左上から3番目のリンクが「遊び場投稿」である' do
        new_parks_link = find_all('a')[3].native.inner_text
        expect(new_parks_link).to match(/遊び場投稿/i)
      end
      it 'エリアで検索リンクが表示される: 左上から4番目のリンクが「エリアで検索」である' do
        area_link = find_all('a')[4].native.inner_text
        expect(area_link).to match(/エリアで検索/i)
      end
      it 'マイページリンクが表示される: 左上から5番目のリンクが「マイページ」である' do
        mypage_link = find_all('a')[5].native.inner_text
        expect(mypage_link).to match(/マイページ/i)
      end
      it 'ログアウトリンクが表示される: 左上から6番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[6].native.inner_text
        expect(logout_link).to match(/ログアウト/i)
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
      logout_link = find_all('a')[6].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end
