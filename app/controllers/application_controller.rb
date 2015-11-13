class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def initialize_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key       = '5WHrltMd3j4YTA1YTZoUET8DT'
      config.consumer_secret    = 'kjnJ03shic0YKmtMA5tkA09gaw8cQLbPaLzbSCEevUBl2HDtA5'
      config.oauth_token        = '68107269-fWxJ2V3HlQNmVRVaSZoEXzU2KiC8an6h4o1WxR0tN'
      config.oauth_token_secret = 'RO2Rg58MtSxzRTPd4hsPaEWQdhPnOvWicvBqkzDIZqOOu'
    end
  end
end
