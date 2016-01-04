class TweetSearch < ActiveRecord::Base

  attr_accessor :tweet_amount

  has_many :tweets
  has_many :tweet_analysis

  validates_presence_of :full_text

  def to_csv
    CSV.generate do |csv|
      csv << [:id,:twittos,:created_at,:annotation]
      tweets.each do |tweet|
        csv << tweet.attributes.values_at("id","twittos","text","created_at","annotation")
      end
    end
  end

end
