class Admin::ParksController < ApplicationController
  def index
    @parks = Park.all
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
      flash[:notice] = "遊び場情報を変更しました"
      redirect_to admin_park_path(@park)
    else
      flash[:notice] = "遊び場情報の変更に失敗しました"
      render "edit"
    end
  end

  def destroy
    @park = Park.find(params[:id])
    @park.destroy
    redirect_to admin_parks_path
  end

  private

  def park_params
    params.require(:park).permit(:genre_id, :name, :introduction, :address, :latitude, :longitude, :phone, :start_time, :end_time, :child_age, :child_moon_age, images: [] )
  end
end
