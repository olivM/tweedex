class Panel < ActiveRecord::Base
  
  has_many :tags, :dependent => :destroy
  
  has_many :panel_tweets, :dependent => :destroy
  has_many :tweets, :through => :panel_tweets

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
