class SearchController < ApplicationController
  def index
    @user = Twitter.user('bdmac97')
    puts @user
    tweeps = TweepSearch.new
    puts tweeps.search(:user => 'bdmac97')
  end
end
