class TweetAnalysis < ActiveRecord::Base

  belongs_to :tweet_search

  def gather_related_tweets
    @tweets = tweet_search.tweets
  end
  
  def analyse
    raise NotImplementedError
  end

end
