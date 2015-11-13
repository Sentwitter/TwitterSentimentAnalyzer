class TweetSearchesController < ApplicationController

  @tweet_search

  def create
    initialize_client
    @tweet_search = TweetSearch.new(params[:tweet_search])
    @client.search(@tweet_search.full_text)
  end




end
