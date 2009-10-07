class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string  :tweetid
      t.string  :text
      t.string  :from_user
      t.string  :to_user
      t.string  :lang
      t.string  :profile_img
      t.integer :timestamp
      t.datetime :published_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
