class TableComment < ActiveRecord::Migration
  def change
  	create_table :comments
    add_column :comments, :asin, :string
    add_column :comments, :user_id, :string
    add_column :comments, :date, :string
    add_column :comments, :content, :string
    add_column :comments, :friend_id, :integer
    add_column :comments, :item_id, :integer
  	add_index :comments, :item_id 
  end
end
