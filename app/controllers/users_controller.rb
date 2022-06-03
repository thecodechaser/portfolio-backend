class UsersController < ApplicationController

  def data
    @user = current_user
  end

end