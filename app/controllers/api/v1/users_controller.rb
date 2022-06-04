class Api::V1::DoctorsController < ApplicationController
  def register
    new_user = User.new(name: params[:name], email: params[:email], password: params[:password])
    if new_user.save
      render json: { success: true, message: 'User created', data: { user: new_user } }, status: :created
    else
      render json: { success: false, errors: new_user.errors }, status: :unprocessable_entity
    end
  end
end