class Admin::ParksController < ApplicationController
  before_action :authenticate_admin!

  def index
    @parks = Park.where.not(latitude: nil).order(created_at: :desc).page(params[:page]).per(8)
    @butparks = Park.where(latitude: nil).order(created_at: :desc)
  end

  def show
    @park = Park.find(params[:id])
  end

  def edit
    @park = Park.find(params[:id])
  end

  def update
     @park = Park.find(params[:id])
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
    @park = Park.find(params[:id])
    @park.destroy
    redirect_to admin_parks_path
  end

  def search
    @results = @q.result.order(created_at: :desc).page(params[:page]).per(8)
  end

  private

  def set_q
    @q = Park.ransack(params[:q])
  end

  def park_params
    params.require(:park).permit(:genre_id, :name, :introduction, :address, :latitude, :longitude, :phone, :start_time, :end_time, :child_age, :child_moon_age, images: [] )
  end
end
