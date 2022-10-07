class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!  
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
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
