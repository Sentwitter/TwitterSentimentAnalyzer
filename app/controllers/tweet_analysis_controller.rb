class TweetAnalysisController < ApplicationController

	@tweet_search
	@tweet_analysis
	@results

	def create
		matching_analysis = TweetAnalysis.where(tweet_analysis_params)
		if matching_analysis.empty?
			@tweet_search = TweetSearch.find(tweet_analysis_params[:tweet_search_id])
			@tweet_analysis = (tweet_analysis_params[:type]).constantize.new(tweet_search: @tweet_search)
			@results = @tweet_analysis.analyse
			@tweet_analysis.save
			redirect_to tweet_analysis_path(@tweet_analysis)
		else
			redirect_to tweet_analysis_path(matching_analysis.first)
		end
		rescue RuntimeError
			flash[:notice] = "vous n'avez pas annoté assez de tweets sur cette recherche pour lancer ce type d'analyse"
			redirect_to :back
	end

	def show
 		@tweet_search = TweetSearch.find(params[:id])
		@tweet_analysis = KeywordAnalysis.new(tweet_search: @tweet_search)
		@results = @tweet_analysis.analyse
	end

	def tweet_analysis_params
		params.require(:tweet_analysis).permit(:tweet_search_id, :type)
	end
end