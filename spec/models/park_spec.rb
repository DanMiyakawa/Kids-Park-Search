# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Parkモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject {park.valid? }

    let(:customer) {create(:customer) }
    let(:genre) {create(:genre) }
    let!(:park) { build(:park, customer_id: customer.id) }

    context "nameカラム" do
      it "空欄でないこと" do
        park.name = ""
        is_expected.to eq false
      end
    end

    context "introductionカラム" do
      it "空欄でないこと" do
        park.introduction = ""
        is_expected.to eq false
      end
      it "100文字以内であること:100文字は○" do
        park.introduction = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it "200文字以内であること:201文字は×" do
        park.introduction = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end
  describe "アソシエーションのテスト" do
    context "Customerモデルとの関係" do
      it "N:1となっている" do
        expect(Park.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end
end