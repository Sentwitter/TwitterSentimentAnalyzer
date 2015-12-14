class AddHandAnnotatedToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :hand_annotated, :boolean, default: 0
  end
end
