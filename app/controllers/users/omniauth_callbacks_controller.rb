class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def twitter
    @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end

