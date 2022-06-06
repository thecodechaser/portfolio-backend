class Api::V1::CommentsController < ApplicationController

  def index 
    if request.headers['X-AUTH-TOKEN']
      user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
      if user
        post = Post.find(params[:post_id])
        comments = post.comments
        if comments
          render json: { success: true, message: 'Comments loaded', data: { comments: comments } }, status: :ok
        else
          render json: { success: false, errors: comments.errors }, status: :unprocessable_entity
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
        comment = Comment.find(params[:id])
        post = comment.post
        post.comments_counter -= 1
        post.save
        if comment.destroy
          render json: { success: true, message: 'Comment deleted', data: { comment: comment} }, status: :ok
        else
          render json: { success: false, errors: 'Wrong comment id' }, status: :unprocessable_entity
        end
      else
        render json: { success: false, errors: 'Wrong authentication token' }, status: :unprocessable_entity
      end
    else
      render json: { success: false, message: 'please sign in or add the token' }, status: :ok
    end
  end
end