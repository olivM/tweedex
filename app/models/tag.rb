class Tag < ActiveRecord::Base
  
  belongs_to :panel
  has_many :synonyms, :dependent => :destroy
  
  has_many :tweet_tags, :dependent => :destroy
  has_many :tweets, :through => :tweet_tags

  has_many :tag_stats, :dependent => :destroy

  def add_synonym(name)
    Synonym.create(:name => name, tag_id => self.id)
  end

  def self.update_stats
    
    Tag.find(:all, :limit => 5, :order => 'fetched_at asc ').each do |tag|
      tag_count = tag.tweets.count(:conditions => { :published_at => Date.today.to_time..Time.now} )
      stat = tag.tag_stats.find_or_create_by_date(Date.today)
      stat.count = tag_count
      stat.save
    end
    
  end
  
  def stats
    self.tag_stats.find(:all, :limit => 30, :order => "date asc").collect{|s| s.count }
  end
  
  def graph_url

    if self.stats.nil? or self.stats.length == 0
      return ''
    end

    g = GoogleChart::LineChart.new('100x50', nil, false)
    g.data self.name, self.stats
    g.show_legend = false
    g.axis :x, :labels => [] # Empty labels
    g.axis :y, :labels => [] # Empty labels

    g.to_url

  end
    
  def self.fetch
    
    require 'twitter'

      tags = Tag.find(:all, :limit => 15, :order => "fetched_at ASC")
      tags_list = tags.collect{|tag| tag.name.gsub(/ /, '+') }.join(' OR ')
            
      tags_fetched_at = tags.first.fetched_at ? tags.first.fetched_at : 2.minutes.ago

      if FAKE_CONTENT
        results = Array.new(rand(15))
      else
        results = Twitter::Search.new(tags_list).lang('fr').fetch().since(tags_fetched_at).results
      end
      
      tags.each do |tag|
        tag.fetched_at = Time.now
        tag.save
      end
    
    if ! results.nil?
      results.each do |tweet|
        if FAKE_CONTENT
          tweet = Tweet.create_fake(tags_fetched_at)
        else
          tweet = Tweet.find_or_create_by_tweetid(:tweetid => tweet.id, :text => tweet.text, :timestamp => Time.parse(tweet.created_at).to_i, :published_at => tweet.created_at, :from_user => tweet.from_user, :lang => tweet.iso_language_code, :profile_img => tweet.profile_img_url)
        end
        
        tags.each do |tag|
          p tag
          p "tag.panel"
          p tag.panel
          if tweet.text.downcase.include? tag.name.downcase
            tag.tweets << tweet unless tag.tweets.include? tweet
            tag.panel.tweets << tweet unless tag.panel.tweets.include? tweet
          end
        end
      end
    end
    
  end
  
end












