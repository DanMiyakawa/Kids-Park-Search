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
      it "200文字以内であること:300文字は○" do
        park.introduction = Faker::Lorem.characters(number: 300)
        is_expected.to eq true
      end
      it "200文字以内であること:301文字は×" do
        park.introduction = Faker::Lorem.characters(number: 301)
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
    context "Genreモデルとの関係" do
      it "N:1となっている" do
        expect(Park.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end
    context "Commentモデルとの関係" do
      it "1:Nとなっている" do
        expect(Park.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
  end
end