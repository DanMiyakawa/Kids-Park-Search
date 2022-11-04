class Public::CommentsController < ApplicationController

  def create
    @park = Park.find(params[:park_id])
    @comment = Comment.new
    @park_comments = Comment.includes(:park).where(park_id: @park).order(created_at: :desc)
    park = Park.find(params[:park_id])
    comment = current_customer.comments.new(comment_params)
    comment.park_id = park.id
    comment.score = Language.get_data(comment_params[:comment])
    comment.save
  end

  def destroy
    @park = Park.find(params[:park_id])
    @comment = Comment.new
    @park_comments = Comment.includes(:park).where(park_id: @park).order(created_at: :desc)
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :comment_image, :child_age, :child_moon_age)
  end

end
