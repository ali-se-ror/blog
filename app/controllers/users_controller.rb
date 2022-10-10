class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    unless @user.update(user_params)
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    if @user.destroy
      render json: { message: "User has been deleted successfuly!" }, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def reset_password
    return render json: { message: "User not found against given email" }, status: :unauthorized unless @current_user.present?
    if @current_user.update(password_params)
      return render json: { message: "Password updated successfully" }
    else
      return render json: { message: "Password not updated" }, status: :unauthorized
    end
  end

  private

  def find_user
    unless @user = User.find_by_username(params[:_username])
      render json: { errors: 'User not found' }, status: :not_found
    end
  end

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation, :role)
  end

  def password_params
    params.permit(:password, :password_confirmation)
  end
end
