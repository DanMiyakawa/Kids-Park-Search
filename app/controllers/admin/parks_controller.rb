class Admin::ParksController < ApplicationController
  before_action :authenticate_admin!
  include Common
  before_action :set_park, only: [:show, :edit, :update, :destroy]

  def index
    @parks = Park.where.not("latitude = ? or longitude = ?", "nil", "nil").order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
  end

  def edit
  end

  def update
    #添付画像を個別に削除
    if params[:park][:image_ids]
      params[:park][:image_ids].each do |image_id|
        image = @park.images.find(image_id)
        image.purge
      end
    end

    if @park.update(park_params)
      redirect_to admin_park_path(@park)
    else
      render "edit"
    end
  end

  def destroy
    @park.destroy
    redirect_to admin_parks_path
  end

  def search
    @results = @q.result.where.not("latitude = ? or longitude = ?", "nil", "nil").order(created_at: :desc).page(params[:page]).per(8)
  end

  private

  def set_q
    @q = Park.ransack(params[:q])
  end

  def park_params
    params.require(:park).permit(:genre_id, :name, :introduction, :address, :latitude, :longitude, :phone, :start_time, :end_time, :child_age, :child_moon_age, images: [] )
  end
end
