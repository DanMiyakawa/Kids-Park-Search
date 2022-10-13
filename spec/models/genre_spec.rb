# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Parkモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject {genre.valid? }

    let(:customer) {create(:customer) }
    let(:park) {create(:park) }
    let!(:genre) { build(:genre) }

    context "nameカラム" do
      it "空欄でないこと" do
        genre.name = ""
        is_expected.to eq false
      end
    end
    end
  end

  describe "アソシエーションのテスト" do
    context "Parkモデルとの関係" do
      it "1:Nとなっている" do
        expect(Genre.reflect_on_association(:parks).macro).to eq :has_many
      end
    end
  end