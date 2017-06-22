class UsersController < ApplicationController
  def show
    @user = current_user
  end
  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :remember_me)
  end
end
