class API::V1::PostsController <  ApplicationController

  def index
    posts = Post.all 
    if posts
      render json: { success: true, message: 'Posts loaded', data: { user: posts } }, status: :created
    else
      render json: { success: false, errors: posts.errors }, status: :unprocessable_entity
    end
  end

  def create

  end

  def destory

  end
end