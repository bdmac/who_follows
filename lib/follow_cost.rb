# FollowCost API with HTTParty Gem

require 'rubygems'
require 'httparty'

class FollowCost
  include HTTParty
  base_uri "http://followcost.com"
  
  def initialize()
  end
  
  def search(options={})
    user = options.delete(:user) || nil
    if user
      self.class.get("/#{user}.json", options)
    end
  end
end