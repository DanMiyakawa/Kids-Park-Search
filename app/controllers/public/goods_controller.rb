class Public::GoodsController < ApplicationController

  def create
    @park = Park.find(params[:park_id])
    @comment = Comment.find(params[:comment_id])
    comment = Comment.find(params[:comment_id])
    good = current_customer.goods.new(comment_id: comment.id)
    good.save
  end

  def destroy
    @park = Park.find(params[:park_id])
    @comment = Comment.find(params[:comment_id])
    comment = Comment.find(params[:comment_id])
    good = current_customer.goods.find_by(comment_id: comment.id)
    good.destroy
  end

end
