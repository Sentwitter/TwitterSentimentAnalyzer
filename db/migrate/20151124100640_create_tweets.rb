class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :tweet_id
      t.string :twittos
      t.string :text
      t.integer :annotation, default: -1
      t.timestamps null: false
    end
  end
end
