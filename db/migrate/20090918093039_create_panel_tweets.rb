class CreatePanelTweets < ActiveRecord::Migration
  def self.up
    create_table :panel_tweets do |t|
      t.integer :panel_id
      t.integer :tweet_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :panel_tweets
  end
end
