class Tweet < ActiveRecord::Base

  validates :twittos, presence: true
  validates :text, presence: true, allow_nil: false

  scope :not_hand_annotated, -> { where(hand_annotated: 0) }

  before_save :clean

  belongs_to :tweet_search

  def clean
    remove_url
  end

  URI_REGEX = %r"((?:(?:[^ :/?#]+):)(?://(?:[^ /?#]*))(?:[^ ?#]*)(?:\?(?:[^ #]*))?(?:#(?:[^ ]*))?)"

  def remove_url
    text = self.text
    self.text = text.split(URI_REGEX).collect do |s|
      unless s =~ URI_REGEX
        s
      end
    end.join
  end

end
