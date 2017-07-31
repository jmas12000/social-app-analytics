class SessionsController < ApplicationController
  #richonrails version
=begin
  def create  
   user = User.from_omniauth(env["omniauth.auth"])
   session[:user_id] = @user.id
   redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are signed out"
  end
=end
#railscast version
  def create  
   @user = User.find_or_create_from_auth_hash(auth_hash)
   session[:user_id] = @user.id
   redirect_to root_path
  end

  def destroy
    request.env['omniauth.auth']
    redirect_to root_path, notice: "You are signed out"
  end
  protected
#=begin
def auth_hash
    request.env['omniauth.auth']
  end
#=end
  
  
end
