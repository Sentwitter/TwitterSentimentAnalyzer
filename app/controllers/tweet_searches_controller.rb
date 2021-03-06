class TweetSearchesController < ApplicationController

  @tweet_search
  @tweet_searches
  @results

  def create
    @tweet_search = TweetSearch.new(tweet_search_params)
    @results      = @client.search(@tweet_search.full_text, lang: 'fr')

    @results.take(@tweet_search.tweet_amount.to_i).each do |tweet|
      infos = tweet_info(tweet)
      Tweet.create(infos)
    end if @tweet_search.save
    redirect_to tweet_search_path(@tweet_search)
  end

  def index
    @tweet_searches = TweetSearch.all.paginate(page: params[:page])
  end

  def show
    @tweet_search = TweetSearch.find(params[:id])
    @tweets = @tweet_search.tweets.paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.html
      format.csv { send_data @tweet_search.to_csv }
    end
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
    params.require(:tweet_search).permit(:full_text,:tweet_amount)
  end

end
