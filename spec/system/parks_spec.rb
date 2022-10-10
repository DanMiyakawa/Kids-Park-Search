# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let!(:park) { create(:park, name:'hoge',introduction:'body',address:'大阪府大阪市中央区',genre_id:'1') }
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
        expect(page).to have_link "", href: parks_path
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end

  describe "新規投稿画面のテスト" do
	    before do
	      visit new_park_path
	    end
    context '投稿処理に関するテスト' do
      it '投稿に失敗する' do
        click_button '新規投稿'
        expect(page).to have_content 'error'
        expect(current_path).to eq('/new_park_path')
      end
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'park[name]', with: Faker::Lorem.characters(number:5)
	      fill_in 'park[introduction]', with: Faker::Lorem.characters(number:20)
	      fill_in 'park[address]', with: Faker::Lorem.characters(number:10)
	      fill_in 'park[genre_id]', with: Faker::Lorem.characters(number:1)
	      click_button '新規投稿'
	      expect(page).to have_current_path parks_path(Park.last)
	      end
      end
    end
end