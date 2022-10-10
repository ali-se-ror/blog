class CommentsController < ApplicationController
  before_action :authorize_request
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    @comments = Comment.where(card_id: params[:card_id])
    render json: @comments, status: :ok
  end

  def show
    render json: @comment, status: :ok
  end

  def create
    @comment = @current_user.comments.new(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      render json: { message: "Comment has been deleted!" }
    else
      render json: @comment.errors, json: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def comment_params
    params.permit(:content, :card_id)
  end

  def set_comment
    unless @comment = @current_user.comments.find_by(id: params[:comment_id])
      render json: { message: "Comment not found!" }, status: :not_found
    end
  end
end
