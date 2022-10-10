class ApplicationController < ActionController::API

  rescue_from CanCan::AccessDenied do |exception|
    render json: {error: "You are not allowed to do this action"}, status: :ok
  end

  def not_found
    render json: { error: 'not_found' }
  end

  # def current_user
  #   current_user =  User.find_by(email: "awais@example.com")
  # end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def is_user_admin
    unless @current_user.role == "admin"
      render json: { message: "Only admin can delete user from List." }, status: :unauthorized
    end
  end
end


