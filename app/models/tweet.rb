#require 'httparty'
#require 'json'
class Tweet < ActiveRecord::Base
#belongs_to :user 
#include HTTParty

# Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
=begin 
base_uri  "https://api.twitter.com/1.1/"

  def initialize (email, password)
    @auth = {
  end
  
  def user_home_timeline
    response = self.class.get("statuses/home_timeline.json?screen_name=curent_user.screen_name&count=20", 
    headers:
=end

 belongs_to :user

  validates :user_id, :body, presence: true

  before_create :post_to_twitter

  def post_to_twitter
    user.twitter.update(body)
  end
  def home_timeline(options)
	  since_id = options[:since_id] ? "&since_id=#{options[:since_id]}" : ""
	  get "/statuses/home_timeline.json?trim_user=true" + since_id
  end

end
