class HomeController < ApplicationController
  @tweet_search

  def index
    @tweet_search = TweetSearch.new
  end

end
