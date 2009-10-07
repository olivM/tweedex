class CreateTweetTags < ActiveRecord::Migration
  def self.up
    create_table :tweet_tags do |t|
      t.integer :tag_id
      t.integer :tweet_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tweet_tags
  end
end
