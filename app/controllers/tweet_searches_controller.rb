class TweetSearchesController < ApplicationController

  @tweet_search
  @tweet_searches
  @results

  def create
    @tweet_search = TweetSearch.new(tweet_search_params)
    @results      = session[:client].search(@tweet_search.full_text, lang: 'fr')
    render :show
    Thread.new do
      @results.each do |tweet|
        infos = tweet_info(tweet)
        Tweet.create(infos)
      end if @tweet_search.save
    end
  end

  def index
    @tweet_searches = TweetSearch.all.paginate(page: params[:page])
  end

  def show
    @tweet_search = TweetSearch.find(params[:id])
    @tweets = @tweet_search.tweets.paginate(page: params[:page], per_page: 15)
  end

  def tweet_info(tweet)
    {
      tweet_id: tweet.id,
      twittos: tweet.user.screen_name,
      text: tweet.text,
      tweet_search: @tweet_search
    }
  end



  def tweet_search_params
    params.require(:tweet_search).permit(:full_text)
  end

end
