
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authenticate_request!, except: [:index, :show]

  # GET /posts (returns all posts)
  def index
    posts = Post.all
    render json: posts
  end

  # GET /user_posts (returns posts for the current user)
  def user_posts
    posts = @current_user.posts
    render json: posts
  end
  
  # GET /posts/:id (returns a specific post by ID)
  def show
    render json: @post
  end

  def create
    post = @current_user.posts.new(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head :no_content
  end

  def authenticate_request!
    auth_header = request.headers['Authorization']
    token = auth_header&.split(' ')&.last
    @current_user = User.find_by(token: token)
    
    unless @current_user
      render json: { error: 'Not Authorized' }, status: 401
    end
  end
  
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end





# app/controllers/posts_controller.rb

# class PostsController < ApplicationController
#     # before_action :set_post, only: [:show, :update, :destroy]
#     before_action :authenticate_request!, except: [:index, :show]

#     # GET /posts (returns all posts)
#   def index
#     posts = Post.all
#     render json: posts
#   end

#   # GET /user_posts (returns posts for the current user)
#   # def user_posts
#   #   posts = @current_user.posts
#   #   render json: posts
#   # end
  
#     def show
#       posts = @current_user.posts
#       # @post = Post.find(params[:id])
#       render json: posts
#     end
  
#     def create
#       post = @current_user.posts.new(post_params)
#       if post.save
#         render json: post, status: :created
#       else
#         render json: { errors: post.errors }, status: :unprocessable_entity
#       end
#     end
    
  
#     def update
#       if @post.update(post_params)
#         render json: @post
#       else
#         render json: { errors: @post.errors }, status: :unprocessable_entity
#       end
#     end
  
#     def destroy
#       @post.destroy
#       head :no_content
#     end
#     def authenticate_request!
#       auth_header = request.headers['Authorization']
#       token = auth_header&.split(' ')&.last
#       @current_user = User.find_by(token: token)
      
#       unless @current_user
#         render json: { error: 'Not Authorized' }, status: 401
#       end
#     end
    
  
#     private
  
#     def set_post
#       @post = Post.find(params[:id])
#     end
  
#     def post_params
#       params.require(:post).permit(:title, :content, :user_id)
#     end
#   end
  