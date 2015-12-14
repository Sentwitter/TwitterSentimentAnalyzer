class AddTweetSearchIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :tweet_search_id, :integer
  end
end
