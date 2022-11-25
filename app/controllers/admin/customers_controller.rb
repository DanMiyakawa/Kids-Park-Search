class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:show, :update]

  def index
    @customers = Customer.order(created_at: :desc).all.page(params[:page]).per(10)
  end

  def show
    @customer_count = @customer.parks.order(created_at: :desc)
    @parks = @customer_count.page(params[:page]).per(10)
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customers_path
    else
      render admin_customers_path(@customer)
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:is_deleted)
  end
end
