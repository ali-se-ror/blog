class RepliesController < ApplicationController
  before_action :authorize_request
  before_action :find_card, only: [:index, :show, :create, :destroy, :update]
  before_action :set_reply, only: [:show, :update, :destroy]
  # GET /replies
  def index
    @replies = @card.comments.find_by(id: params[:comment_id]).replies
    render json: @replies
  end

  # GET /replies/1
  def show
    render json: @reply
  end

  # POST /replies
  def create
    @reply = @card.comments.find_by(id: params[:comment_id]).replies.create(content: params[:content], card_id: params[:card_id], user_id: @current_user.id)
    if @reply.save
      render json: @reply, status: :created
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /replies/1
  def update
    if @reply.update(content: params[:content])
      render json: @reply, status: :ok
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  # DELETE /replies/1
  def destroy
    return render json: { message: "card comments not present" } unless @reply = @card.comments.find_by(id: params[:comment_id])
    return render json: { message: "reply not present" } unless @reply = @reply.replies.find_by(id: params[:reply_id])

    if @reply.destroy
      render json: { message: "Reply has been deleted." }, status: :ok
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  private

  def find_card
    unless @card = Card.find_by(id: params[:card_id])
      return render json: { message: "Card not found!" }, status: :not_found
    end
  end

  def set_reply
    unless @reply = @card.comments.find_by(id: params[:comment_id]).replies.find_by(id: params[:reply_id])
      return render json: { message: "Reply not found!" }, status: :not_found
    end
  end

end
