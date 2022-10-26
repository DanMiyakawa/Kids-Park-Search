class Public::ContactsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_user

  def index
    #ログイン者の問合せ内容のみ
    @contacts = Contact.where(customer_id: current_customer.id).order(created_at: :desc).page(params[:page]).per(8)
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

  def ensure_guest_user
    if current_customer.nickname == "ゲストユーザー"
      redirect_to root_path
    end
  end
end
