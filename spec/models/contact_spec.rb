# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Contactモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject {contact.valid? }

    let(:customer) {create(:customer) }
    let!(:contact) { build(:contact, customer_id: customer.id) }

    context "titleカラム" do
      it "空欄でないこと" do
        contact.title = ""
        is_expected.to eq false
      end
      it "20文字以内であること:20文字は○" do
        contact.title = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it "20文字以内であること:21文字は×" do
        contact.title = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context "bodyカラム" do
      it "空欄でないこと" do
        contact.body = ""
        is_expected.to eq false
      end
      it "100文字以内であること:100文字は○" do
        contact.body = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it "200文字以内であること:201文字は×" do
        contact.body = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end
  
  describe "アソシエーションのテスト" do
    context "Customerモデルとの関係" do
      it "N:1となっている" do
        expect(Contact.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end
end