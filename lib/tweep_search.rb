# TweepSearch API with HTTParty Gem

require 'rubygems'
require 'httparty'

class TweepSearch
  include HTTParty
  include Geokit::Geocoders
  base_uri 'http://api.tweepsearch.com/search'
  
  def initialize()
  end
  
  def search(options={})
    user = options.delete(:user) || nil
    tweeps = []
    if user
      tweeps = self.class.get("/#{user}.json", options)
    else
      tweeps = self.class.get(".json", options)
    end
    
    return nil unless tweeps.code == 200
      
    klout = Klout.new
    fc = FollowCost.new
    tweeps = tweeps.map do |tweep|
      # Grab Klout score
      res = klout.search(:user => tweep['screen_name'])
      if res.code == 202
        tweep['kscore'] = -1
      elsif res.code != 200
        tweep['kscore'] = -1
      else
        tweep['kscore'] = res['user']['score']['kscore'].to_f
        tweep['kclass'] = res['user']['score']['kclass']
        tweep['kclass_description'] = res['user']['score']['kclass_description']
      end
      
      # Grab FollowCost data
      res = fc.search(:user => tweep['screen_name'])
      if res.code == 200
        tweep['created_at'] = res['twitter_created_at']
        tweep['status_count'] = res['statuses_count']
        tweep['tweets_per_day'] = res['average_tweets_per_day'].to_f
      end
    
      # Handle geolocation of each friend/follower
      if (tweep['location'] && !tweep['location'].empty?)
        location = tweep['location'].sub(/iPhone: /, '')
        res=MultiGeocoder.geocode(location)
        tweep['latitude'] = res.lat
        tweep['longitude'] = res.lng
      end
      tweep
    end
    tweeps
  end
end