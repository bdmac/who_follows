class SearchController < ApplicationController
  def index
    @user = Twitter.user('bdmac97')
    puts @user
    tweepsearch = TweepSearch.new
    @tweeps = tweepsearch.search(:user => 'bdmac97')
    puts @tweeps.inspect
  end
end
