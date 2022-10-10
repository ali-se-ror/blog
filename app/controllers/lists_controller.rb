class ListsController < ApplicationController
  before_action :authorize_request
  before_action :set_list, only: [:show, :destroy, :update]
  before_action :is_user_admin, only: [:create]

  # GET /lists
  def index
    @lists = @current_user.lists
    render json: @lists, status: :ok
  end

  # GET /lists/1
  def show
    render json: @list, status: :ok
  end

  # POST /lists
  def create
    @list = @current_user.lists.create(list_params)
    if @list.save
      render json: @list, status: :created
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/1
  def destroy
    if @list.destroy
      render json: { message: "List has been deleted successfuly!" }, status: :ok
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def list_params
    params.permit(:title)
  end

  def set_list
    unless @list = @current_user.lists.find_by(id: params[:id])
      render json: { message: "List not found!" }, status: :not_found
    end
  end
end
