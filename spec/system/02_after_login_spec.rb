require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:customer) { create(:customer) }
  let!(:other_customer) { create(:customer) }
  let!(:park) { create(:park, customer: customer) }
  let!(:other_park) { create(:park, customer: other_customer) }

  before do
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※ログアウトは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      it 'お気に入りを押すと、自分のお気に入り一覧画面に遷移する' do
        favorite_link = find_all('a')[1].native.inner_text
        favorite_link = favorite_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link favorite_link
        is_expected.to eq '/customers/' + customer.id.to_s + "/favorites"
      end
      it '遊び場一覧を押すと、遊び場一覧画面に遷移する' do
        parks_link = find_all('a')[2].native.inner_text
        parks_link = parks_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link parks_link
        is_expected.to eq '/parks'
      end
      it '遊び場投稿を押すと、遊び場投稿画面に遷移する' do
        new_parks_link = find_all('a')[3].native.inner_text
        new_parks_link = new_parks_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link new_parks_link
        is_expected.to eq '/parks/new'
      end
      it 'エリアで検索を押すと、エリア検索画面に遷移する' do
        area_parks_link = find_all('a')[4].native.inner_text
        area_parks_link = area_parks_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link area_parks_link
        is_expected.to eq '/parks/prefecture'
      end
      it 'マイページを押すと、マイページ画面に遷移する' do
        mypage_link = find_all('a')[5].native.inner_text
        mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link mypage_link
        is_expected.to eq '/customers/' + customer.id.to_s
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit parks_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/parks'
      end
    end
  end

  describe '投稿画面のテスト' do
    context '投稿成功のテスト' do
      before do
        visit new_park_path
        fill_in 'park[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'park[introduction]', with: Faker::Lorem.characters(number: 30)
        fill_in 'park[address]', with: Faker::Lorem.characters(number: 15)
        #fill_in 'park[genre_id]', with: @park.genre_id
        # select "公園", from: 'park[genre_id]'
       # binding.pry
      end


      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '新規投稿' }.to change(customer.parks, :count).by(0)
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        click_button '新規投稿'
        expect("/parks/2").to eq '/parks/' + Park.last.id.to_s
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit park_path(park)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/parks/' + park.id.to_s
      end
      it '遊び場の名前が表示される' do
        expect(page).to have_content park.name
      end
      it '遊び場の紹介文が表示される' do
        expect(page).to have_content park.introduction
      end
      it '遊び場の住所が表示される' do
        expect(page).to have_content park.address
      end
      it '遊び場の編集リンクが表示される' do
        expect(page).to have_link '編集する', href: edit_park_path(park)
      end
      it '遊び場の削除リンクが表示される' do
        expect(page).to have_link '削除する', href: park_path(park)
      end
    end

    context '投稿成功のテスト' do
      before do
        visit new_park_path
        fill_in 'park[name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'park[introduction]', with: Faker::Lorem.characters(number: 20)
        fill_in 'park[address]', with: Faker::Lorem.characters(number: 10)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '新規投稿' }.to change(customer.parks, :count).by(0)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集する'
        expect(current_path).to eq '/parks/' + park.id.to_s + '/edit'
      end
    end

    context '削除リンクのテスト' do
      before do
        click_link '削除する'
      end

      it '正しく削除される' do
        expect(Park.where(id: park.id).count).to eq 0
      end
      it 'リダイレクト先が、遊び場一覧画面になっている' do
        expect(current_path).to eq '/parks'
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_park_path(park)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/parks/' + park.id.to_s + '/edit'
      end
      it '「遊び場情報の変更」と表示される' do
        expect(page).to have_content '遊び場情報の変更'
      end
      it 'name編集フォームが表示される' do
        expect(page).to have_field 'park[name]', with: park.name
      end
      it 'introduction編集フォームが表示される' do
        expect(page).to have_field 'park[introduction]', with: park.introduction
      end
      it 'address編集フォームが表示される' do
        expect(page).to have_field 'park[address]', with: park.address
      end
      it '変更を保存ボタンが表示される' do
        expect(page).to have_button '変更を保存'
      end
    end

    context '編集成功のテスト' do
      before do
        @park_old_name = park.name
        @park_old_introduction = park.introduction
        fill_in 'park[name]', with: Faker::Lorem.characters(number: 4)
        fill_in 'park[introduction]', with: Faker::Lorem.characters(number: 19)
        click_button '変更を保存'
      end

      it 'nameが正しく更新される' do
        expect(park.reload.name).not_to eq @park_old_name
      end
      it '紹介文が正しく更新される' do
        expect(park.reload.introduction).not_to eq @park_old_introduction
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/parks/' + park.id.to_s
      end
    end
  end

  describe '自分のユーザ詳細画面のテスト' do
    before do
      visit customer_path(customer)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/' + customer.id.to_s
      end
      it '投稿一覧に自分の投稿のnameが表示され、リンクが正しい' do
        expect(page).to have_link park.name, href: park_path(park)
      end
      it '投稿一覧に自分の投稿のaddressが表示される' do
        expect(page).to have_content park.address
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_link '', href: customer_path(other_customer)
        expect(page).not_to have_content other_park.name
        expect(page).not_to have_content other_park.address
      end
    end
  end

  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_customer_path(customer)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/' + customer.id.to_s + '/edit'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'customer[nickname]', with: customer.nickname
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'customer[profile_image]'
      end
      it 'email編集フォームに自分の自己紹介文が表示される' do
        expect(page).to have_field 'customer[email]', with: customer.email
      end
      it '更新ボタンが表示される' do
        expect(page).to have_button '更新'
      end
    end

    context '更新成功のテスト' do
      before do
        @customer_old_nickname = customer.nickname
        @customer_old_email = customer.email
        fill_in 'customer[nickname]', with: Faker::Lorem.characters(number: 9)
        click_button '更新'
      end

      it 'nicknameが正しく更新される' do
        expect(customer.reload.nickname).not_to eq @customer_old_nickname
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/customers/' + customer.id.to_s
      end
    end
  end
end
