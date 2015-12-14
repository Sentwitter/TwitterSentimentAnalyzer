class CreateTweetSearches < ActiveRecord::Migration
  def change
    create_table :tweet_searches do |t|
      t.string :full_text
      t.timestamps null: false
    end
  end
end
