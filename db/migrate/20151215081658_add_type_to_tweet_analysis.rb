class AddTypeToTweetAnalysis < ActiveRecord::Migration
  def change
    add_column :tweet_analysis, :type, :string
  end
end
