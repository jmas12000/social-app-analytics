#require 'httparty'
#require 'json'
class Tweet < ActiveRecord::Base

#include HTTParty
  belongs_to :user

  validates :user_id, :body, presence: true
  before_create :post_to_twitter

  def post_to_twitter
    user.twitter.update(body)
  end
  
  def user_home_timeline
    response = self.class.get("statuses/home_timeline.json?screen_name=curent_user.screen_name&count=20") 
  end
end
