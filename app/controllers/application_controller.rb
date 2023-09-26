class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = jwt_decode(token)
    @current_user = User.find(decoded[:user_id])
  rescue JWT::DecodeError => e
    render json: { errors: 'Invalid user or password' }, status: :unauthorized
  end
end
