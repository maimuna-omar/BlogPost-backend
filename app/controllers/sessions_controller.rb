# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
  
    if user && user.authenticate(params[:password])
        token = SecureRandom.hex(20)
        user.update(token: token)
        render json: { status: 'logged in', user: user, token: token }
    else
        render json: { status: 'error', message: 'Incorrect email or password' }, status: :unauthorized
    end
  end
  
     
  def destroy
    @current_user.update(token: nil) if @current_user
    render json: { status: 'logged out' }
  end
      
    end
    