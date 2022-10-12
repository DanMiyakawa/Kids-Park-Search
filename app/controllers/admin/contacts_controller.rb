class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update(contact_params)
    flash[:notice] = "更新に成功しました。"
    redirect_to request.referer
  end

  private

  def contact_params
    params.require(:contact).permit(:status, :memo)
  end
end
