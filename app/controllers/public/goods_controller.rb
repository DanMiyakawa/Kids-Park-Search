class Public::GoodsController < ApplicationController
  before_action :set_good, only: [:create, :destroy]

  def create
    comment = Comment.find(params[:comment_id])
    good = current_customer.goods.new(comment_id: comment.id)
    good.save
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    good = current_customer.goods.find_by(comment_id: comment.id)
    good.destroy
  end

  private

  def set_good
    @park = Park.find(params[:park_id])
    @comment = Comment.find(params[:comment_id])
  end

end
