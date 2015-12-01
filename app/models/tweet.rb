class Tweet < ActiveRecord::Base

  validates :twittos, presence: true
  validates :text, presence: true, allow_nil: false

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
