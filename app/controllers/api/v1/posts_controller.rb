# frozen_string_literal: true

class API::V1::PostsController < ApplicationController
  def index
    if request.headers['X-AUTH-TOKEN']
      user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
      if user
        posts = Post.all
        if posts
          render json: { success: true, message: 'Posts loaded', data: { user: posts } }, status: :created
        else
          render json: { success: false, errors: posts.errors }, status: :unprocessable_entity
        end
      else
        render json: { success: false, errors: 'Wrong authentication token' }, status: :unprocessable_entity
      end
    else
      render json: { success: false, message: 'please sign in or add the token' }, status: :ok
    end
  end

  def create
    if request.headers['X-AUTH-TOKEN']
      user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
      if user
        new_post = user.posts.new(title: params[:title], h_one: params[:h_one], p_one: params[:p_one], h_two: params[:h_two], p_two: params[:p_two],
                                  h_three: params[:h_three], p_three: params[:p_three], conclusion: params[:conclusion], photo_one: params[:photo_one],
                                  photo_two: params[:photo_two])
        if new_post.save
          render json: { success: true, message: 'Post created', data: { post: new_post } }, status: :created
        else
          render json: { success: false, errors: new_post.errors }, status: :unprocessable_entity
        end
      else
        render json: { success: false, errors: 'Wrong authentication token' }, status: :unprocessable_entity
      end
    else
      render json: { success: false, message: 'please sign in or add the token' }, status: :ok
    end
  end

  def destory
    if request.headers['X-AUTH-TOKEN']
      user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
      if user
    post = Post.find(params[:id])
    if post.destory
      render json: { success: true, message: 'Post deleted', data: { post: } }, status: :deleted
    else
      render json: { success: false, errors: new_post.errors }, status: :unprocessable_entity
    end
  else
    render json: { success: false, errors: 'Wrong authentication token' }, status: :unprocessable_entity
  end
else
  render json: { success: false, message: 'please sign in or add the token' }, status: :ok
end
  end
end
