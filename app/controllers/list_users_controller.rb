class ListUsersController < ApplicationController
  before_action :set_list_user, only: [:show, :update]
  before_action :authorize_request
  before_action :is_user_admin, only: [:create, :destroy]

  def index
    @list_users = ListUser.all
    render json: @list_users, status: :ok
  end

  def show
    render json: @list_user, status: :ok
  end

  def create
    @list_user = ListUser.new(list_user_params)
    if @list_user.save
      render json: @list_user, status: :created
    else
      render json: @list_user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @list_user.update(list_user_params)
      render json: @list_user, status: :ok
    else
      render json: @list_user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @list_user = ListUser.find_by(user_id: params[:user_id], list_id: params[:list_id])
    if @list_user.destroy
      render json: { message: "User has been unassigned from the List." }, status: :ok
    else
      render json: @list_user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_list_user
    @list_user = ListUser.find(params[:id])
  end

  def list_user_params
    params.permit(:list_id, :user_id)
  end

end
