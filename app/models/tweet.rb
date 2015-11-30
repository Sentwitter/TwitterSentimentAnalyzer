class Tweet < ActiveRecord::Base

  validates :twittos, presence: true
  validates :text, presence: true, allow_nil: false

end
