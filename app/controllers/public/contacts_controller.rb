class Public::ContactsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @contacts = Contact.where(customer_id: current_customer.id).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.customer_id = current_customer.id
    if @contact.save
      redirect_to thanks_contacts_path
    else
      render :new
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:title, :body)
  end
end
