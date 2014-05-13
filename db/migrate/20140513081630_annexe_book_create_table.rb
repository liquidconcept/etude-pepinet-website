class AnnexeBookCreateTable < ActiveRecord::Migration
  def self.up
    create_table :annexe_books do |t|
      t.string :title
      t.text :content
      t.string :category
      t.string :link
      t.string :file
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
  
  def self.down
    drop_table :annexe_books
  end
end
