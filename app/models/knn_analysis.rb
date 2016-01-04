class KnnAnalysis < TweetAnalysis

  attr_accessor :k

  def classified_tweets
    @classified_tweets ||
    @classified_tweets = {
      positive_tweets:  [],
      negative_tweets:  [],
      neutral_tweets:   []
    }
  end

  def analyse
    self.k = 20 unless self.k

    if tweet_search.tweets.hand_annotated.count < k
      raise "NotEnoughTweets"
    end
    classified_tweets

    tweet_search.tweets.hand_annotated.positive.each { |t|
      add_positive_tweet t
    }

    tweet_search.tweets.hand_annotated.neutral.each { |t|
      add_neutral_tweet t
    }

    tweet_search.tweets.hand_annotated.negative.each { |t|
      add_negative_tweet t
    }

    tweet_search.tweets.not_hand_annotated.each do |tweet|
      reset_neighbours

      classified_tweets[:positive_tweets].each do |tweet2|
        unless tweet.id == tweet2.id do
          tweets_distance = distance tweet tweet2
          if neighbours_number < k
            @positive_neighbours.add({tweet: tweet2, distance: tweets_distance })
          else
            if furthest_neighbour_distance > tweets_distance
              remove_furthest_neighbour
              @positive_neighbours.add({tweet: tweet2, distance: tweets_distance })
            end
          end
          sort_neighbours
          end
        end
      end

      classified_tweets[:neutral_tweets].each do |tweet2|
        unless tweet.id == tweet2.id do
          tweets_distance = distance tweet tweet2
          if neighbours_number < k
            @neutral_neighbours.add({tweet: tweet2, distance: tweets_distance })
          else
            if furthest_neighbour_distance > tweets_distance
              remove_furthest_neighbour
              @neutral_neighbours.add({tweet: tweet2, distance: tweets_distance })
            end
          end
          sort_neighbours
          end
        end
      end

      classified_tweets[:negative_tweets].each do |tweet2|
        unless tweet.id == tweet2.id do
          tweets_distance = distance tweet tweet2
          if neighbours_number < k
            @negative_neighbours.add({tweet: tweet2, distance: tweets_distance })
          else
            if furthest_neighbour_distance > tweets_distance
              remove_furthest_neighbour
              @negative_neighbours.add({tweet: tweet2, distance: tweets_distance })
            end
          end
          sort_neighbours
          end
        end
      end

      category = most_frequent_neighbour_category

      if category == :positive
        add_positive_tweet tweet
      elsif category == :neutral
        add_neutral_tweet tweet
      else
        add_negative_tweet tweet
      end
    end
    self.update(neutral_tweets: classified_tweets[:neutral_tweets].length)
    self.update( negative_tweets: classified_tweets[:negative_tweets].length)
    self.update( positive_tweets: classified_tweets[:positive_tweets].length)
    self.save
  end

  def most_frequent_neighbour_category
    [
      [@positive_neighbours,:positive],
      [@negative_neighbours,:negative],
      [@neutral_neighbours, :neutral]
    ].max_by{ |elt|
      elt[0].length
    }[1]
  end

  def distance(tweet1, tweet2)
    text1 = tweet1.text
    text2 = tweet2.text
    words1 = text1.split(" ")
    words2 = text2.split(" ")
    total_length = (words1.length + words2.length)
    common_words_number = (words1.length - (words1 - words2).length)
    (total_length - common_words_number) / total_length
  end



  def add_positive_tweet tweet
    @classified_tweets[:positive_tweets].push tweet
  end

  def add_negative_tweet tweet
    @classified_tweets[:negative_tweets].push tweet
  end

  def add_neutral_tweet tweet
    @classified_tweets[:neutral_tweets].push tweet
  end

  def reset_neighbours
    @positive_neighbours = []
    @neutral_neighbours  = []
    @negative_neighbours = []
  end

  def sort_neighbours
    @positive_neighbours = @positive_neighbours.sort_by { |n| n[:distance] }
    @negative_neighbours = @negative_neighbours.sort_by { |n| n[:distance] }
    @neutral_neighbours = @neutral_neighbours.sort_by { |n| n[:distance] }
  end

  def furthest_neighbour_distance
    [@positive_neighbours.last[:distance],@negative_neighbours.last[:distance],@neutral_neighbours.last[:distance]].max
  end

  def furthest_neighbour_class
    [:positive,:negative,:neutral].at([@positive_neighbours.last,@negative_neighbours.last,@neutral_neighbours.last].each_with_index.max_by { |n,i| n[:distance] }[1])
  end

  def is_a_closer_neighbours? tweet_distance_hash
    tweet_distance_hash[:distance] < furthest_neighbour_distance
  end

  def remove_furthest_neighbour
    case furthest_neighbour_class
    when :positive
      @positive_neighbours.pop
    when :neutral
      @neutral_neighbours.pop
    when :negative
      @negative_neighbours.pop
    end
  end

  def neighbours_number
    @positive_neighbours.length + @negative_neighbours.length + @neutral_neighbours.length
  end
end
