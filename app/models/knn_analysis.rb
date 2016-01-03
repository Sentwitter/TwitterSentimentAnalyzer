class KnnAnalysis < TweetAnalysis

  k = 20

  def analyse
    if @tweet_search.tweets.hand_annotated.count < k
      raise "NotEnoughTweets"
    end
    positive_tweets = 0
    neutral_tweets  = 0
    negative_tweets = 0
    @tweet_search.tweets.not_hand_annotated.each do |tweet|

      neighbours: []
      do
        @tweet_search.tweets.hand_annotated.each do |tweet2|
          unless tweet.id == tweet2.id || tweet.annotation == -1 do
            tweets_distance = distance tweet tweet2
            if neighbours.length < k
              neighbours.add({tweet: tweet2, distance: tweets_distance })
            else
              furthest_neighbour = neighbours.max_by { |n| n[:distance] }
              if furthest_neighbour[:distance] > tweets_distance
                neighbours.delete furthest_neighbour
                neighbours.add({tweet: tweet2, distance: tweets_distance })
              end
            end
          end
        end
        pos = (neighbours.select { |n| n.annotation == 2 }).count
        neu = (neighbours.select { |n| n.annotation == 1 }).count
        neg = (neighbours.select { |n| n.annotation == 0 }).count
        category = max(pos,neg,neu)

      end
      if category == pos
        positive_tweets = positive_tweets + 1
      elsif category == neu
        neutral_tweets = neutral_tweets + 1
      else
        negative_tweets = negative_tweets + 1
      end
    end

  end

  def distance tweet1 tweet2
    text1 = tweet1.text
    text2 = tweet2.text
    words1 = tweet1.split(" ")
    words2 = tweet2.split(" ")
    total_length = (words1.length + words2.length)
    common_words_number = (words1.length - (words1 - words2).length)
    distance = (total_length - common_words_number) / total_length
  end
end
