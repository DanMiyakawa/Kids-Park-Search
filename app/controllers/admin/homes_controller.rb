class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    contacts = Contact.all
    # 対応状況での検索表示
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
    # 住所が判断できない公園を取得
    @badparks = Park.where(latitude: nil).order(created_at: :desc).page(params[:page]).per(8)
  end
end
