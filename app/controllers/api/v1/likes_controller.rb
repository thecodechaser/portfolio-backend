class Api::V1::LikesController < ApplicationController

  def index 
    if request.headers['X-AUTH-TOKEN']
      user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
      if user
        likes = Like.all
        if likes
          render json: { success: true, message: 'Likes loaded', data: { likes: likes } }, status: :ok
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
    if request.headers['X-AUTH-TOKEN']
      user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
      if user
        new_comment = Comment.new(comment: params[:comment], author: params[:author], avatar: params[:avatar],
        post_id: params[:post_id])
        if new_comment.save
          render json: { success: true, message: 'Comment created', data: {comment: new_comment } }, status: :created
        else
          render json: { success: false, errors: new_comment.errors }, status: :unprocessable_entity
        end
      else
        render json: { success: false, errors: 'Wrong authentication token' }, status: :unprocessable_entity
      end
    else
      render json: { success: false, message: 'please sign in or add the token' }, status: :ok
    end
  end

  def destroy
    if request.headers['X-AUTH-TOKEN']
      user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
      if user
        like = Like.find(params[:id])
        post = like.post
        post.likes_counter -= 1
        post.save
        if like.destroy
          render json: { success: true, message: 'Like deleted', data: { like: like} }, status: :ok
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