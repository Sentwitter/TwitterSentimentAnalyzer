class CreateTweetAnalysis < ActiveRecord::Migration
  def change
    create_table :tweet_analysis do |t|
      t.integer :tweet_search_id
      t.integer :neutral_tweets
      t.integer :positive_tweets
      t.integer :negative_tweets
      t.datetime :last_performed
      t.timestamps null: false
    end
  end
end
