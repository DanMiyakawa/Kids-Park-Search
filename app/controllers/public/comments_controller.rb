class Public::CommentsController < ApplicationController
  before_action :correct_customer, only: [:destroy]
  before_action :set_comment, only: [:create, :index, :show, :destroy]

  def create
    park = Park.find(params[:park_id])
    comment = current_customer.comments.new(comment_params)
    comment.park_id = park.id
    comment.score = Language.get_data(comment_params[:comment])
    unless comment.save
      flash.now[:alert] = "投稿に失敗しました。"
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
  end

  def index
  end

  def show
  end

  private

  def set_comment
    @park = Park.find(params[:park_id])
    @comment = Comment.new
    @park_comments = Comment.includes(:park).where(park_id: @park).order(created_at: :desc).page(params[:page]).per(4)
  end

  def comment_params
    params.require(:comment).permit(:comment, :comment_image, :child_age, :child_moon_age)
  end

  def correct_customer
    @comment = Comment.find(params[:id])
    @customer = @comment.customer
    redirect_to(parks_path) unless @customer == current_customer
  end

end
