class ChangedNewsAddedPublishedAt < ActiveRecord::Migration
  def self.up
    add_column :news, :published_at, :datetime
  end
  
  def self.down
    remove_column :news, :published_at
  end
end
