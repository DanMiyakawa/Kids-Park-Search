class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_user
  before_action :ensure_correct_customer, only: [:show, :edit,:updatey, :unsubscribe, :withdrawal, :favorites]

  def show
    @customer = Customer.find(params[:id])
    @customer_count = @customer.parks.order(created_at: :desc)
    @parks = @customer_count.page(params[:page]).per(10)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
       redirect_to customer_path(current_customer)
    else
       render :edit
    end
  end

  def unsubscribe
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:park_id)
    @parks = Park.where(id: favorites).where.not("latitude = ? or longitude = ?", "nil", "nil")
    @genres = Genre.find(@parks.pluck(:genre_id))
    # ブックマーク内での検索
    # キーワードでのあいまい検索
    if params[:word]
      @word = (params[:word])
      @all_parks = @parks.where(['name LIKE ? OR address LIKE ?', "%#{@word}%", "%#{@word}%"])
    # ジャンルでの検索
    elsif params[:genre_id]
      @all_parks = @parks.where(genre_id: params[:genre_id])
    else
      @all_parks = @parks
    end
    @favorite_parks = Kaminari.paginate_array(@all_parks.order(created_at: :desc)).page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :nickname, :introduction, :profile_image)
  end

  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.nickname == "ゲストユーザー"
      redirect_to root_path
    end
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to root_path
    end
  end
end
