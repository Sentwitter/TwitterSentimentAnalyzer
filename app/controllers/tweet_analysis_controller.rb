class TweetAnalysisController < ApplicationController

	@tweet_search
	@tweet_analysis
	@results

	def create
		@tweet_analysis = (params[:type]).new(tweet_search: @tweet_search)
		@results = @tweet_analysis.analyse
	end

	def show
		@tweet_search = TweetSearch.find(params[:id])
		@tweet_analysis = KeywordAnalysis.new(tweet_search: @tweet_search)
		@results = @tweet_analysis.analyse
	end
end