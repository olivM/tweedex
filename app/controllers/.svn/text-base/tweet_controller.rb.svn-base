
class TweetController < ApplicationController

  layout 'main'

  def index
    
    @panel = Panel.find_by_name(params[:panel])

    @tweets = @panel.tweets.find(:all, :limit => "25", :order => " timestamp desc").slice(10, 15)
    
    if @tweets.nil?
      @since = ''
    else
      @since = @tweets.first.timestamp
    end
    
  end

  def tweet

    panel = Panel.find_by_name(params[:panel])

    tweet = panel.tweets.find(:first, :conditions => "timestamp > '#{params[:since]}'", :order => " timestamp asc")
    
    if tweet.nil?
      render :json => nil
    else
      render :json => [{ :html => tweet.html, :timestamp => tweet.timestamp }]
    end

  end

  

end
