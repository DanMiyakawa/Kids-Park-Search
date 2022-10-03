class Public::CommentsController < ApplicationController

  def create
    @park = Park.find(params[:park_id])
    @comment = Comment.new
    park = Park.find(params[:park_id])
    comment = current_customer.comments.new(comment_params)
    comment.park_id = park.id
    comment.save
  end

  def destroy
    @park = Park.find(params[:park_id])
    @comment = Comment.new
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :comment_image)
  end

end
