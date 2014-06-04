class ChangeChapterToString < ActiveRecord::Migration
  def change
    remove_column :book_updates, :article_number
  end
end
