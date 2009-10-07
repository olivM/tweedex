class TweetTag < ActiveRecord::Base
  
  belongs_to :tag
  belongs_to :tweet
  
  validates_presence_of :tag_id, :tweet_id
  validates_uniqueness_of :tag_id, :scope => :tweet_id
  
end
