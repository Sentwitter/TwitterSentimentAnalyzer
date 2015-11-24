class Tweet < ActiveRecord::Base

  attr_accessor :twittos, :text, :annotated, :annotation

  validates :twittos, presence: true
  validates :text, presence: true

end
