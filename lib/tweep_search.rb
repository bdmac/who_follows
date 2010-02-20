# From: http://railstips.org/2008/7/29/it-s-an-httparty-and-everyone-is-invited
# Author: John Nunemaker

# Delicious API with HTTParty Gem

require 'rubygems'
require 'httparty'

class TweepSearch
  include HTTParty
  base_uri 'http://api.tweepsearch.com/search'
  
  def initialize()
  end
  
  def search(options={})
    user = options.delete(:user) || nil
    if user
      self.class.get("/#{user}.json", options)
    else
      self.class.get(".json", options)
    end
  end
end