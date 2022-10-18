class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_user, only: [:show, :edit, :update, :destroy, :unsubscribe, :withdrawal, :favorites]
  before_action :ensure_correct_customer, only: [:show, :edit,:updatey, :unsubscribe, :withdrawal, :favorites]

  def show
    @customer = Customer.find(params[:id])
    @parks = @customer.parks.order(created_at: :desc).page(params[:page]).per(10)
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
    @favorite_parks = Park.find(favorites)
    @favorite_parks = Kaminari.paginate_array(@favorite_parks).page(params[:page]).per(8)
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
