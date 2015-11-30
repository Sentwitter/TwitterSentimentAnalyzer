class TweetSearchesController < ApplicationController

  @tweet_search
  @results

  def create
    initialize_client
    @tweet_search = TweetSearch.new(params[:tweet_search])
    @results      = @client.search(@tweet_search.full_text, lang: 'fr', count: 15)
    @results.each do |tweet|
      infos = tweet_info(tweet)
      raise
      Tweet.create(infos)
    end
  end

  def tweet_info(tweet)
    {
      tweet_id: tweet.id,
      twittos: tweet.user.screen_name,
      text: tweet.text
    }
  end

end
