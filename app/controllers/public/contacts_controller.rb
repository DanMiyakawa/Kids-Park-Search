class Public::ContactsController < ApplicationController
  def index
    @contacts = Contact.where(customer_id: current_customer.id)
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
      flash[:notice] = "お問い合わせに失敗しました"
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
