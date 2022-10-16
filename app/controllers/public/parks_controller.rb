class Public::ParksController < ApplicationController
  before_action :set_q, only: [:index, :search]
  before_action :authenticate_customer!, except: [:index, :show, :search, :prefecture, :prefecture_search]

  def index
    #経度・緯度が取得できていないものは表示しない
    @parks = Park.where.not(latitude: nil).order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @park = Park.find(params[:id])
    @comment = Comment.new
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
      redirect_to park_path(@park)
    else
      render "edit"
    end
  end

  def new
    @park = Park.new
  end

  def create
    @park = Park.new(park_params)
    @park.customer_id = current_customer.id
    if @park.save
      redirect_to park_path(@park.id)
    else
      render :new
    end
  end

  def destroy
    @park = Park.find(params[:id])
    @park.destroy
    redirect_to parks_path
  end

  def search
    #緯度が空のデータは表示しない仕様
    @results = @q.result.where.not(latitude: nil).order(created_at: :desc).page(params[:page]).per(8)
  end

  def prefecture
  end

  def prefecture_search
    @name = (params[:name])
    #prefectureページからのデータで部分検索
    @prefectures = Park.where(['address LIKE ?', "%#{@name}%"]).order(created_at: :desc).page(params[:page]).per(8)
    @prefecture = Park.where(['address LIKE ?', "%#{@name}%"]).order(created_at: :desc).limit(1)
  end


  private

  def set_q
    @q = Park.ransack(params[:q])
  end

  def park_params
    params.require(:park).permit(:genre_id, :name, :introduction, :address, :latitude, :longitude, :phone, :start_time, :end_time, :child_age, :child_moon_age, images: [] )
  end
end
