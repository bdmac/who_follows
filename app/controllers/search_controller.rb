class SearchController < ApplicationController
  include Geokit::Geocoders
  
  def index
    if params[:name] && !params[:name].empty?
      @user = Twitter.user(params[:name])
      if @user.error == "Not found"
        flash.now[:error] = "No twitter user named #{params[:name]} was found.  Are you sure you typed it correctly?"
      else
        tweepsearch = TweepSearch.new
        sort = params[:sort] || 'followers_count'
        params[:sort] = sort
        @tweeps = tweepsearch.search(:user => params[:name], :query => {:sort => sort, :count => 25, :query => params[:filter]})
        
        # Find the highest tweets/day
        @most_per_day = @tweeps.inject do |highest, tweep|
          highest['tweets_per_day'] > tweep['tweets_per_day'] ? highest : tweep
        end
        
        # Find the highest kscore
        @highest_kscore = @tweeps.inject do |highest, tweep|
          puts "#{highest['kscore']} > #{tweep['kscore']}?"
          highest['kscore'] > tweep['kscore'] ? highest : tweep
        end
        
        # Map them!
        begin
          location = @user.location.sub(/.*: /, '')
          res = MultiGeocoder.geocode(location)
          @map = GoogleMap::Map.new
          @map.center = GoogleMap::Point.new(res.lat, res.lng)
          @map.zoom = 5
          @tweeps.each do |tweep|
            if tweep['latitude'] && tweep['longitude']
              marker_html = "#{tweep['screen_name']} | #{tweep['name']}<br/>#{tweep['location']}"
              @map.markers << GoogleMap::Marker.new(:map => @map, 
                                                    :lat => tweep['latitude'], 
                                                    :lng => tweep['longitude'],
                                                    :html => marker_html,
                                                    :marker_hover_text => tweep['screen_name'])
            end
          end
        rescue RuntimeError
          flash.now[:error] = "There was a problem mapping your followers."
        end
      end
    elsif params[:name]
      flash.now[:error] = "Did you forget to enter a name?"
    end
  end
end
