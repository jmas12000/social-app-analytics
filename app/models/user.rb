class User < ActiveRecord::Base
  require 'rubygems'
  require 'bundler/setup'

  require 'twitter'
  require 'json'
  has_many :tweets
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:twitter]
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
#railscast version
  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create #do |user|
    user.update(
      password:  Devise.friendly_token[0,20],
      name: auth_hash.info.name,  # assuming the user model has a name
      profile_image: auth_hash.info.image, # assuming the user model has an image
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret,
      screen_name: auth_hash.extra.raw_info.screen_name
    )
    user
  end
  
  def twitter
   
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_APP_ID"]
      config.consumer_secret     = ENV["TWITTER_APP_SECRET"]
      config.access_token        = token
      config.access_token_secret = secret
     
    end
  end
  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
 