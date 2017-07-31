class ApplicationController < ActionController::Base
  
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
=begin before_action :configure_permitted_parameters, if: :devise_controller?
  #before_filter :load_tweets
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :email, :password, :password_confirmation, :username, :screen_name]
    )
  
    devise_parameter_sanitizer.permit(:edit, keys: [
      :email, :password, :password_confirmation, :username]
    )
  end
  #def load_tweets
  #  @tweets = Twitter.user_timeline[0..4] # For this demonstration lets keep the tweets limited to the first 5 available.
  #end
=end  
  
  
end
