class TweetSearch < ActiveRecord::Base

  has_many :tweets

  validates_presence_of :full_text

  attr_accessor :full_text


end
