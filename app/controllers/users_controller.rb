# app/controllers/users_controller.rb

class UsersController < ApplicationController
    def index
        users = User.all
        render json: users
      end
      
      def create
        user = User.new(user_params)
        if user.save
          # Generate token after successful registration
          token = SecureRandom.hex(20)
          user.update(token: token)
          render json: { status: 'registered and logged in', user: user, token: token }
        else
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end
      
    # def create
    #   user = User.new(user_params)
    #   if user.save
    #     render json: { user: user, status: :created }
    #   else
    #     render json: { errors: user.errors }, status: :unprocessable_entity
    # end
    # end
  
    def show
      user = User.find(params[:id])
      user_id = params[:id]

      render json: user
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
  end
  