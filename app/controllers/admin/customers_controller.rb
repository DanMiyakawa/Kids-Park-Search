class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  include Common
  before_action :set_customer, only: [:show, :update]

  def index
    @all_customer = Customer.all
    @customers = @all_customer.order(created_at: :desc).page(params[:page]).per(10)
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

  def customer_params
    params.require(:customer).permit(:is_deleted)
  end
end
