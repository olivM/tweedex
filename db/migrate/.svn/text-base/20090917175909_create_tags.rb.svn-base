class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.integer :panel_id
      t.datetime :fetched_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
