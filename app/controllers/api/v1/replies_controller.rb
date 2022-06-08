# frozen_string_literal: true

class Api::V1::RepliesController < ApplicationController
  def index
    if request.headers['Authorization']
      user = User.find_by_api_token(request.headers['Authorization'])
      if user
        comment = Comment.find(params[:comment_id])
        replies = comment.replies
        if replies
          render json: { success: true, message: 'Replies loaded', data: { replies: replies} }, status: :ok
        else
          render json: { success: false, errors: replies.errors }, status: :unprocessable_entity
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
        new_reply = Reply.new(reply: params[:comment], author: params[:author], avatar: params[:avatar],
                                  comment_id: params[:comment_id])
        if new_reply.save
          render json: { success: true, message: 'Reply created', data: { reply: new_reply } }, status: :created
        else
          render json: { success: false, errors: new_reply.errors }, status: :unprocessable_entity
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
        comment = Comment.find(params[:id])
        post = comment.post
        post.comments_counter -= 1
        post.save
        if comment.destroy
          render json: { success: true, message: 'Comment deleted', data: { comment: } }, status: :ok
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
