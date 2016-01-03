class TweetSearch < ActiveRecord::Base

  attr_accessor :tweet_amount

  has_many :tweets
  has_many :tweet_analysis

  validates_presence_of :full_text


end
