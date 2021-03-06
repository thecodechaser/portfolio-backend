# frozen_string_literal: true

class Api::V1::LikesController < ApplicationController
  def index
    if request.headers['Authorization']
      user = User.find_by_api_token(request.headers['Authorization'])
      if user
        post = Post.find(params[:post_id])
        likes = post.likes
        if likes
          render json: { success: true, message: 'Likes loaded', data: { likes: } }, status: :ok
        else
          render json: { success: false, errors: likes.errors }, status: :unprocessable_entity
        end
      else
        render json: { success: false, errors: 'Wrong authentication token' }, status: :unprocessable_entity
      end
    else
      render json: { success: false, message: 'please sign in or add the token' }, status: :ok
    end
  end

  def create
    if request.headers['Authorization']
      user = User.find_by_api_token(request.headers['Authorization'])
      if user
        new_like = Like.new(post_id: params[:post_id])
        if new_like.save
          render json: { success: true, message: 'Like created', data: { like: new_like } }, status: :created
        else
          render json: { success: false, errors: new_like.errors }, status: :unprocessable_entity
        end
      else
        render json: { success: false, errors: 'Wrong authentication token' }, status: :unprocessable_entity
      end
    else
      render json: { success: false, message: 'please sign in or add the token' }, status: :ok
    end
  end

  def destroy
    if request.headers['Authorization']
      user = User.find_by_api_token(request.headers['Authorization'])
      if user
        like = Like.find(params[:id])
        post = like.post
        post.likes_counter -= 1
        post.save
        if like.destroy
          render json: { success: true, message: 'Like deleted', data: { like: } }, status: :ok
        else
          render json: { success: false, errors: 'Wrong like id' }, status: :unprocessable_entity
        end
      else
        render json: { success: false, errors: 'Wrong authentication token' }, status: :unprocessable_entity
      end
    else
      render json: { success: false, message: 'please sign in or add the token' }, status: :ok
    end
  end
end
