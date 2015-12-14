class KeyWordAnalysis < Analysis

  def perform
    tweets = Tweet.where(tweet_search: self.tweet_search)
    positive = 0
    negative = 0
  end
end
