class TweetSearch < ActiveRecord::Base

  has_many :tweets
  has_many :tweet_analysis

  validates_presence_of :full_text



end
