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

      # moved to panel
    
  end
  
end












