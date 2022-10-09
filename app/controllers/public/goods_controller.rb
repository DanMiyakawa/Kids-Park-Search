class Public::GoodsController < ApplicationController

  def create
    comment = Comment.find(params[:comment_id])
    good = current_customer.goods.new(comment_id: comment.id)
    good.save
    redirect_to request.referer
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    good = current_customer.goods.find_by(comment_id: comment.id)
    good.destroy
    redirect_to request.referer
  end

end
