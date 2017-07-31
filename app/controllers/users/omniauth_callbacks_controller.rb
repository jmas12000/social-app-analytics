class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def twitter
     
   # render :text => "<pre>" + env["omniauth.auth"].to_yaml and return
   # raise "Implement me for twitter"
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

#class OmniauthCallbacksController < Devise::OmniauthCallbacksController
=begin
  def instagram
    generic_callback( 'instagram' )
  end

  def facebook
    generic_callback( 'facebook' )
  end

  def twitter
    generic_callback( 'twitter' )
  end

  def google_oauth2
    generic_callback( 'google_oauth2' )
  end
=end
=begin
  def generic_callback( provider )
    @identity = Identity.find_for_oauth env["omniauth.auth"]
    
    @user = @identity.user || current_user
    if @user.nil?
      @user = User.create( email: @identity.email || "" )
      @identity.update_attribute( :user_id, @user.id )
    end

    if @user.email.blank? && @identity.email
      @user.update_attribute( :email, @identity.email)
    end

    if @user.persisted?
      @identity.update_attribute( :user_id, @user.id )
      # This is because we've created the user manually, and Device expects a
      # FormUser class (with the validations)
      @user = FormUser.find @user.id
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
=end
=begin
def generic_callback( provider )
    @identity = Identity.find_for_oauth env["omniauth.auth"]
    @user = @identity.user || current_user
    if @user.nil?
      @tempUser = User.find_by_email(@identity.email) unless @identity.email.blank?
      if @tempUser.nil?
        @user = User.create( email: @identity.email || nil )
      else
        @user = @tempUser
      end
      @identity.update_attribute( :user_id, @user.id )
    end
    if @user.email.blank? && @identity.email
      @user.update_attribute( :email, @identity.email)
    end
    if @user.persisted?
      @identity.update_attribute( :user_id, @user.id )

      @user = FormUser.find @user.id
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  def upgrade
    scope = nil
    if params[:provider] == "google_oauth2"
      scope = "email,profile,offline,https://www.googleapis.com/auth/admin.directory.user"
    end

    redirect_to user_omniauth_authorize_path( params[:provider] ), flash: { scope: scope }
  end
  
  def setup
    request.env['omniauth.strategy'].options['scope'] = flash[:scope] || request.env['omniauth.strategy'].options['scope']
    render :text => "Setup complete.", :status => 404
  end
end
=end