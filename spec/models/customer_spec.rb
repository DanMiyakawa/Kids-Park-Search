require "rails_helper"

RSpec.describe "Customerモデルのテスト", type: :model do

  describe "バリデーションのテスト" do
    subject { customer.valid? }

    let(:contact) {create(:contact) }
    let(:other_customer) { create(:customer) }
    let!(:customer) { build(:customer) }

    context "nicknameカラム" do
      it "空欄でないこと" do
        customer.nickname = ""
        is_expected.to eq false
      end
      it "2文字以上であること: 2文字は○" do
        customer.nickname = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it "2文字以上であること: 1文字は×" do
        customer.nickname = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it "20文字以下であること: 20文字は○" do
        customer.nickname = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it "20文字以下であること: 21文字は×" do
        customer.nickname = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    end
  end

  describe "アソシエーションのテスト" do
    context "Parkモデルとの関係" do
      it "1:Nとなっている" do
        expect(Customer.reflect_on_association(:parks).macro).to eq :has_many
      end
    end
    context "Contactモデルとの関係" do
      it "1:Nとなっている" do
        expect(Customer.reflect_on_association(:contacts).macro).to eq :has_many
      end
    end
  end