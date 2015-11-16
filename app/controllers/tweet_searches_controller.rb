class TweetSearchesController < ApplicationController

  @tweet_search
  @results

  def create
    initialize_client
    @tweet_search = TweetSearch.new(params[:tweet_search])
    @results = @client.search(@tweet_search.full_text, lang: 'fr')
  end




end
