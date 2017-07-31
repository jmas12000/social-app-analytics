class User < ActiveRecord::Base
  require 'rubygems'
  require 'bundler/setup'

  require 'twitter'
  require 'json'
  has_many :tweets
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
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
#=begin
  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create #do |user|
    user.update(
      #provider: auth_hash.provider,
      #Uid: auth_hash.uid,
    #email:  auth.info.email  while user.email.blank?,
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
#richonrails version
=begin
def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.Uid = auth.uid
      user.name = auth.info.name
      user.Token = auth.credentials.token
      user.Secret = auth.credentials.secret
      user.screen_name = auth.extra.raw_info.screen_name
      user.save!
    end
  end

  
  def tweet(tweet)
   
    client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_APP_ID"]
      config.consumer_secret     = ENV["TWITTER_APP_SECRET"]
      config.access_token        = Token
      config.access_token_secret = Secret
     
    end
   client.update(tweet)

    
  end
=end
  
  
 
  

=begin        
  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    user.update(
      name: auth_hash.info.name,
      image: auth_hash.info.image,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
      )
      user
end

  end
=end
=begin       
  has_many :identities

  def twitter
    identities.where( :provider => "twitter" ).first
  end
  def twitter_client
    @twitter_client ||= Twitter.client( access_token: twitter.accesstoken )
  end

  def facebook
    identities.where( :provider => "facebook" ).first
  end

  def facebook_client
    @facebook_client ||= Facebook.client( access_token: facebook.accesstoken )
  end
  
  def instagram
    identities.where( :provider => "instagram" ).first
  end

  def instagram_client
    @instagram_client ||= Instagram.client( access_token: instagram.accesstoken )
  end

  def google_oauth2
    identities.where( :provider => "google_oauth2" ).first
  end

  def google_oauth2_client
    if !@google_oauth2_client
      @google_oauth2_client = Google::APIClient.new(:application_name => 'HappySeed App', :application_version => "1.0.0" )
      @google_oauth2_client.authorization.update_token!({:access_token => google_oauth2.accesstoken, :refresh_token => google_oauth2.refreshtoken})
    end
    @google_oauth2_client
  end
=end
  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
  
  
end
 