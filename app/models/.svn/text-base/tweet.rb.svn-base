class Tweet < ActiveRecord::Base
  
  has_many :tweet_tags, :dependent => :destroy
  has_many :tags, :through => :tweet_tags

  has_many :panel_tweets, :dependent => :destroy
  has_many :panels, :through => :panel_tweets

  def html
    time_ago = ActionView::Base.new.time_ago_in_words(self.published_at)
    '<li><a class="from_user" href="http://twitter.com/'+self.from_user+'">@'+self.from_user+'</a> - <p>'+self.text+'</p><a href="" class="link">'+time_ago+' ago</a></li>'
  end

  def self.create_fake(since)
    timestamp = since + rand(500)
    published_at = Time.new - Time.new.to_i + timestamp
    Tweet.create(:tweetid => timestamp, :lang => 'fr', :from_user => Faker::Name.name, :text => Faker::Lorem.words(rand(20)).join(' '), :published_at => published_at, :timestamp => timestamp)
  end

end
