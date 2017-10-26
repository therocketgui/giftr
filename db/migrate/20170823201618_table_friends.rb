class TableFriends < ActiveRecord::Migration
  def change
  	create_table :friends
    add_column :friends, :name, :string
    add_column :friends, :birthday, :string
    add_column :friends, :like, :text
    add_column :friends, :user_id, :integer
  	add_index :friends, :user_id 
  end
end
