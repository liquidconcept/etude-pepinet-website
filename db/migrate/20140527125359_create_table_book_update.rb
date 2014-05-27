class CreateTableBookUpdate < ActiveRecord::Migration
  def self.up
    create_table :book_updates do |t|
      t.string :title
      t.text :content
      t.string :chapter
      t.string :file
      t.integer :article_number
      t.string :alinea
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
  
  def self.down
    drop_table :book_updates
  end
end
