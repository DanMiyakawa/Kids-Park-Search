class Public::FavoritesController < ApplicationController
  before_action :set_favorite, only: [:create, :destroy]

  def create
    park = Park.find(params[:park_id])
    favorite = current_customer.favorites.new(park_id: park.id)
    favorite.save
  end

  def destroy
    park = Park.find(params[:park_id])
    favorite = current_customer.favorites.find_by(park_id: park.id)
    favorite.destroy
  end

  private

  def set_favorite
    @park = Park.find(params[:park_id])
  end

end
