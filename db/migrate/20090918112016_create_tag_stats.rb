class CreateTagStats < ActiveRecord::Migration
  def self.up
    create_table :tag_stats do |t|
      t.integer :tag_id
      t.date    :date
      t.integer :count
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tag_stats
  end
end
