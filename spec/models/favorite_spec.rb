# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Favoriteモデルのテスト", type: :model do
  let(:customer) { create(:customer) }
  let(:park) { create(:park, customer_id: customer.id) }
  let(:favorite) { customer.favorites.create(park_id: park.id)}
  let(:destroy_favorite) { customer.favorites.find_by(park_id: park.id).destroy }

  it "遊び場にいいね可能" do
    expect{ favorite }.to change{ Favorite.count }.by(1)
    expect(customer.favorites.count).to eq 1
  end

  it "いいね済みであれば「いいね」解除可能" do
    expect{ favorite }.to change{ Favorite.count }.by(1)
    expect{ destroy_favorite }.to change{ Favorite.count }.by(-1)
    expect(customer.favorites.count).to eq 0
  end

end