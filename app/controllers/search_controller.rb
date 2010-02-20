class SearchController < ApplicationController
  def index
    if params[:name]
      @user = Twitter.user(params[:name])
      puts @user.inspect
      tweepsearch = TweepSearch.new
      @tweeps = tweepsearch.search(:user => params[:name], :query => {:sort => 'followers_count', :count => 100})
      puts @tweeps.inspect
    end
  end
end
