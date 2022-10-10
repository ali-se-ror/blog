class CardsController < ApplicationController
  alias_method :current_user, :authorize_request # Could be :current_member or :logged_in_user
  load_and_authorize_resource
  before_action :find_card, only: [:index, :show, :create, :destroy, :update]

  # GET /cards
  def index
    @cards = @current_user.cards
    render json: @cards, status: :ok
  end

  # GET /cards/1
  def show
    render json: @card, status: :ok
  end

  # POST /cards
  def create
    @card = @current_user.cards.new(card_params)
    if @card.save
      render json: @card, status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1
  def update
    if @card.update(card_params)
      render json: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cards/1
  def destroy
    if @card.destroy
      render json: { message: "Card has been deleted successfully" }, status: :ok
    else
      render json: @card.errors, status: :unprocessable_entity
    end

  end

  private

  def find_card
    unless @card = @current_user.cards.find_by(id: params[:card_id])
      render json: { message: "Card not found!" }, status: :not_found
    end
  end

  def card_params
    params.permit(:title, :description, :list_id)
  end
end
