class Public::ParksController < ApplicationController
  def index
    @parks = Park.all
  end

  def show
    @park = Park.find(params[:id])
  end

  def edit
  end

  def update
  end

  def new
    @park = Park.new
  end

  def create
    @park = Park.new(park_params)
    @park.customer_id = current_customer.id
    if @park.save!
      flash[:notice] = "遊び場を登録しました"
      redirect_to park_path(@park.id)
    else
      flash[:notice] = "遊び場の登録に失敗しました"
      render :new
    end
  end

  def destroy
  end

  private

  def park_params
    params.require(:park).permit(:genre_id, :name, :introduction, :address, :phone, :start_time, :end_time, :child_age, :child_moon_age, :images)
  end
end
