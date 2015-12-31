class CreateTweetAnalysis < ActiveRecord::Migration
  def change
    create_table :tweet_analyses do |t|
      t.integer :tweet_search_id
      t.string  :type
      t.integer :neutral_tweets
      t.integer :positive_tweets
      t.integer :negative_tweets
      t.datetime :last_performed
    end
  end
end
