class Public::ParksController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show, :search, :prefecture, :prefecture_search]
  include Common
  before_action :set_park, only: [:show, :edit, :update, :destroy]
  before_action :correct_customer, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:destroy]

  def index
    #経度・緯度が取得できていないものは表示しない
    @all_parks = Park.where.not("latitude = ? or longitude = ?", "nil", "nil")
    @parks = @all_parks.order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @comment = Comment.new
    @park_comments = Comment.includes(:park).where(park_id: @park).order(created_at: :desc).page(params[:page]).per(4)
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
    @park.destroy
    redirect_to parks_path
  end

  def search
    @result_parks = @q.result.where.not("latitude = ? or longitude = ?", "nil", "nil")
    #緯度が空のデータは表示しない仕様
    @results = @result_parks.order(created_at: :desc).page(params[:page]).per(12)
    #@resultsから最新の投稿を取得
    @result = @result_parks.first
  end

  def prefecture
    @park_addresses = Park.pluck(:address)
  end

  def prefecture_search
    @name = (params[:name])
    #prefectureページからのデータで部分検索
    @prefectures = Park.where(['address LIKE ?', "%#{@name}%"])

    @prefecture_parks = @prefectures.order(created_at: :desc).page(params[:page]).per(12)
    #@prefecturesから最新の投稿を取得
    @prefecture_park = @prefectures.first
  end


  private

  def park_params
    params.require(:park).permit(:genre_id, :name, :introduction, :address, :latitude, :longitude, :phone, :start_time, :end_time, :child_age, :child_moon_age, images: [] )
  end

  def correct_customer
    @park = Park.find(params[:id])
    @customer = @park.customer
    redirect_to(parks_path) unless @customer == current_customer
  end

  def ensure_guest_user
    if current_customer.nickname == "ゲストユーザー"
      redirect_to root_path
    end
  end
end
