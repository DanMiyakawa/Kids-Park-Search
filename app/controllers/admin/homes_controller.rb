class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    contacts = Contact.all
    if params[:status]
      if params[:status] == "確認中"
        @contacts = Contact.where(status: "確認中").page(params[:page]).per(10)
      elsif params[:status] == "対応中"
        @contacts = Contact.where(status: "対応中").page(params[:page]).per(10)
      else
        @contacts = Contact.where(status: "対応済").page(params[:page]).per(10)
      end
    else
      @contacts = contacts.page(params[:page]).per(10)
    end
    @badparks = Park.where(latitude: nil).order(created_at: :desc).page(params[:page]).per(8)
  end
end
