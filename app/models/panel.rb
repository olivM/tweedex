class Panel < ActiveRecord::Base
  
  has_many :tags, :dependent => :destroy
  
  has_many :panel_tweets, :dependent => :destroy
  has_many :tweets, :through => :panel_tweets

  def fetch

    require 'twitter'

    tags = self.tags.find(:all, :limit => 15, :order => "fetched_at ASC")
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
          if tweet.text.downcase.include? tag.name.downcase
            tag.tweets << tweet unless tag.tweets.include? tweet
            tag.panel.tweets << tweet unless tag.panel.tweets.include? tweet
          end
        end
      end
    end

  end

  def self.create_with_tags(name, tags)
    
    panel = Panel.find_or_create_by_name(name)
    
    p panel.name
    
    tags.each do |l|
      
      tag = Tag.find_or_create_by_name(:name => l[0], :panel_id => panel.id)
      p " -> #{tag.name}"
      p tag

	  end

  end
  
  def self.import_all

    if FAKE_CONTENT
      
      Faker::Lorem.words(5).each do |panel_name|
        tags = Faker::Lorem.words(rand(25)).collect{|t| [t] }
        panel = Panel.create_with_tags(panel_name, tags)
      end

    else

	    require 'csv'
      Dir.entries('db/import').each do |file|
        if file =~ /\.csv/
          panel_name = file.gsub(/\.csv$/, '')
	        tags = CSV::Reader.parse(File.open("db/import/#{file}").read)
          panel = Panel.create_with_tags(panel_name, tags)
	      end
	    end

    end

	end
  
end
