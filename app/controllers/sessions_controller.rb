
class SessionsController < ApplicationController
  before_action :set_current_user, only: [:destroy]

  def create
    user = User.find_by(email: params[:email])
  
    if user && user.authenticate(params[:password])
      unless user.token # Only generate a new token if the user doesn't already have one
        token = SecureRandom.hex(20)
        user.update(token: token)
      end
      render json: { status: 'logged in', user: user, token: user.token }
    else
      render json: { status: 'error', message: 'Incorrect email or password' }, status: :unauthorized
    end
  end
 
  def destroy
    if @current_user
      @current_user.update(token: nil)
      render json: { status: 'logged out' }
    else
      render json: { status: 'error', message: 'No active session found' }, status: :not_found
    end
  end

  private

def set_current_user
  token = request.headers['Authorization'] 
  return unless token
  @current_user = User.find_by(token: token)
end

  
end
