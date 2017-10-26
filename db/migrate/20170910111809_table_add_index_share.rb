class TableAddIndexShare < ActiveRecord::Migration
  def change
  	add_index :share_friends, :friend_id 
  end
end
