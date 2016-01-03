class Export < ApplicationController
  def index
    @products = Tweet.all.take(10)
    respond_to do |format|
      format.html
      format.csv { render text: @products.to_csv }
    end
  end
end

