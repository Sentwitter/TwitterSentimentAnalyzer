class Tweet < ActiveRecord::Base

  validates :twittos, presence: true
  validates :text, presence: true, allow_nil: false

  scope :not_hand_annotated, -> { where(hand_annotated: 0) }

  before_save :clean
  
  def clean
    remove_url
    remove_rt
    remove_arobase
    remove_hashtag
    remove_quotes
    transform_price
    different_smiley
  end

  URI_REGEX = %r"((?:(?:[^ :/?#]+):)(?://(?:[^ /?#]*))(?:[^ ?#]*)(?:\?(?:[^ #]*))?(?:#(?:[^ ]*))?)"
  RT_REGEX = %r"RT\s"
  AROBASE_REGEX = %r"@"
  HASHTAG_REGEX = %r"#"
  QUOTES_REGEX = %r"\""
  PRICE_REGEX = %r"[0-9]+[.,]*[0_9]*\p{Sc}"

  POSITIVESMILE_REGEX = %r":[-]?[)DPdp]+"
  NEGATIVESMILE_REGEX = %r":[-]?[(sS]+"

  def remove_url
    text = self.text
    self.text = text.split(URI_REGEX).collect do |s|
      unless s =~ URI_REGEX
        s
      end
    end.join
  end

  def remove_rt
    text = self.text
    self.text = text.split(RT_REGEX).collect do |s|
      unless s=~ RT_REGEX
        s
      end
    end.join
  end

  def remove_arobase
    text = self.text
    self.text = text.split(AROBASE_REGEX).collect do |s|
      unless s =~ AROBASE_REGEX
        s
      end
    end.join
  end

  def remove_hashtag
    text = self.text
    self.text = text.split(HASHTAG_REGEX).collect do |s|
      unless s =~ HASHTAG_REGEX
        s
      end
    end.join
  end

  def remove_quotes
    text = self.text
    self.text = text.split(QUOTES_REGEX).collect do |s|
      unless s =~ QUOTES_REGEX
        s
      end
    end.join
  end

  def transform_price
    text = self.text
    self.text = text.split(PRICE_REGEX).collect do |s|
      s.gsub!(PRICE_REGEX,"X")
    end.join
  end

  def different_smiley
    text = self.text
    self.text = text.split(POSITIVESMILE_REGEX).collect || text.split(NEGATIVESMILE_REGEX).collect do |s|
      unless s = POSITIVESMILE_REGEX && NEGATIVESMILE_REGEX
        s
      end
    end.join
end
