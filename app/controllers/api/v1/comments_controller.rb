class Api::v1::CommentsConrtoller < ApplicationController

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
end