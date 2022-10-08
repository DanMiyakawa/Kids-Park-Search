class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

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
    favorites= Favorite.where(customer_id: @customer.id).pluck(:park_id)
    @favorite_parks = Park.find(favorites)
    @favorite_parks = Kaminari.paginate_array(@favorite_parks).page(params[:page]).per(8)
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :nickname, :introduction, :profile_image)
  end
end
