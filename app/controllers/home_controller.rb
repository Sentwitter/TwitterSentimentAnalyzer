class HomeController < ApplicationController
  @tweet_search
  def index
    @tweet_search = TweetSearch.new
  end

  def set_http_proxy
    session[:client].proxy = params[:proxy]
    redirect_to :root
  end
end
