class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_contact, only: [:show, :update]

  def show
  end

  def update
    @contact.update(contact_params)
    flash[:notice] = "更新に成功しました。"
    redirect_to request.referer
  end

  private

  def contact_params
    params.require(:contact).permit(:status, :memo)
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end

end
