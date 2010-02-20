# TweepSearch API with HTTParty Gem

require 'rubygems'
require 'httparty'

class TweepSearch
  include HTTParty
  base_uri 'http://api.tweepsearch.com/search'
  
  def initialize()
  end
  
  def search(options={})
    user = options.delete(:user) || nil
    puts options.inspect
    tweeps = []
    if user
      tweeps = self.class.get("/#{user}.json", options)
    else
      tweeps = self.class.get(".json", options)
    end
    #klout = Klout.new
    #puts tweeps.inspect
    tweeps = tweeps.map do |tweep|
      #user = Twitter.user(tweep['screen_name'])
      #tweep = tweep.merge({'followers_count' => user.followers_count, 'friends_count' => user.friends_count})
      #puts tweep.inspect
    #  puts klout.search(user)
      tweep
    end
    #puts "AFTER MAP"
    #puts tweeps.inspect
    tweeps
  end
end