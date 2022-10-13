# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Commentモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject {comment.valid? }

    let(:customer) { create(:customer) }
    let(:park) { create(:park, customer_id: customer.id) }
    let(:comment) { build(:comment, park_id: park.id, customer_id: customer.id) }

    context "commentカラム" do
      it '空白でないこと' do
        comment.comment = ""
        is_expected.to eq false
      end
      it "50文字以内であること:50文字は○" do
        comment.comment = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it "50文字以内であること:51文字は×" do
        comment.comment = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
  end
  describe "アソシエーションのテスト" do
    context "Customerモデルとの関係" do
      it "N:1となっている" do
        expect(Comment.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
    context "Parkモデルとの関係" do
      it "N:1となっている" do
        expect(Comment.reflect_on_association(:park).macro).to eq :belongs_to
      end
    end
  end
end