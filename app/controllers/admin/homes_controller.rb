class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    contacts = Contact.all
    # 対応状況での検索表示
    if params[:status]
      if params[:status] == "確認中"
        @all_contact = Contact.where(status: "確認中")
        @contacts = @all_contact.order(created_at: :desc).page(params[:contact]).per(8)
      elsif params[:status] == "対応中"
        @all_contact = Contact.where(status: "対応中")
        @contacts = @all_contact.order(created_at: :desc).page(params[:contact]).per(8)
      else
        @all_contact = Contact.where(status: "対応済")
        @contacts = @all_contact.order(created_at: :desc).page(params[:contact]).per(8)
      end
    else
      @all_contact = contacts
      @contacts = @all_contact.order(created_at: :desc).page(params[:contact]).per(8)
    end
    # 住所が判断できない公園を取得
    @all_badpark = Park.where(latitude: nil).or(Park.where(longitude: nil))
    @badparks = @all_badpark.order(created_at: :desc).page(params[:park]).per(8)

    respond_to do |format|
      format.html
      format.js
    end

  end
end
