# Klout API with HTTParty Gem

require 'rubygems'
require 'httparty'

class Klout
  include HTTParty
  API_KEY = 'd31dfec013753c979f8af6a58affeb72'
  base_uri "http://klout.com/api/twitter/1.1/profiledetail/#{API_KEY}"
  
  def initialize()
  end
  
  def search(options={})
    user = options.delete(:user) || nil
    tweeps = []
    if user
      self.class.get("/#{user}.xml", options)
    end
  end
end