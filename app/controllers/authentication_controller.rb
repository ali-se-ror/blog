class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login
  before_action :set_user, only: [:login]

  # POST /auth/login
  def login
    if @user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: {
        token: token,
        exp: time.strftime("%m-%d-%Y %H:%M"),
        username: @user.username
      }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def set_user
    unless @user = User.find_by_email(params[:email])
      render json: { error: 'User Not Found' }, status: :not_found
    end
  end
end
