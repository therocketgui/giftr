class TableLikes < ActiveRecord::Migration
  def change
  	create_table :likes
    add_column :likes, :title, :string
    add_column :likes, :friend_id, :integer
  	add_index :likes, :friend_id 
  end
end
