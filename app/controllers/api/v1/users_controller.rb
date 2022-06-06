# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  def register
    new_user = User.new(name: params[:name], photo_link: params[:photo_link], bio: params[:bio],
                        portfolio_link: params[:portfolio_link], email: params[:email], password: params[:password])
    if new_user.save
      render json: { success: true, message: 'User created', data: { user: new_user } }, status: :created
    else
      render json: { success: false, errors: new_user.errors }, status: :unprocessable_entity
    end
  end

  def login
    valid = User.find_by(email: params[:email])
    valid_two = User.find_by(email: params[:email]).valid_password?(params[:password]) if valid
    if valid_two
      user = User.find_by(email: params[:email])
      user.api_token = Devise.friendly_token.to_s
      user.save
      render json: { success: true, message: 'Login successfull', data: { api_token: user.api_token } }, status: :ok
    else
      render json: { success: false, message: 'Wrong email or password' }, status: :ok
    end
  end
end
