class Admin::CommentsController < ApplicationController
  def destroy
    @park = Park.find(params[:park_id])
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end
end
