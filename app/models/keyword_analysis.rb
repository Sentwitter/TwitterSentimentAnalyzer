class KeywordAnalysis < TweetAnalysis

  before_save :perform

  def perform
    tweets = Tweet.where(tweet_search: self.tweet_search)
    positive_tweets = 0
    negative_tweets = 0
    neutral_tweets  = 0
    tweets.each do |t|
      tweet_cardinality = 0
      PositiveWords.words.each do |w|
        pos = pos + 1 if t.text.include?(w)
      end
      NegativeWords.words.each do |w|
        pos = pos -1 if t.text.include?(w)
      end

      if tweet_cardinality == 0
        neutral_tweets = neutral_tweets + 1
      elsif tweet_cardinality > 0
        positive_tweets = positive_tweets + 1
      else
        negative_tweets = negative_tweets + 1
      end
    end
    self.positive_tweets  = positive_tweets
    self.neutral_tweets   = neutral_tweets
    self.negative_tweets  = negative_tweets
  end

end
