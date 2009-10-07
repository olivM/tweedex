class TagStat < ActiveRecord::Base
  
  belongs_to :tag
  
  validates_uniqueness_of :date, :scope => :tag_id
  
end
