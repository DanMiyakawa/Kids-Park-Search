class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    @park = Park.find(params[:park_id])
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end
end
