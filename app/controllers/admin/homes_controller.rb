class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @contacts = Contact.all.page(params[:page]).per(10)
    @badparks = Park.where(latitude: nil).order(created_at: :desc).page(params[:page]).per(8)
  end
end
