class TweetAnalysis < ActiveRecord::Base

  belongs_to :tweet_search

  def analyse
    raise NotImplementedError
  end

end
