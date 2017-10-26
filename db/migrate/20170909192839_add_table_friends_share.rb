class AddTableFriendsShare < ActiveRecord::Migration
  def change
  	create_table :share_friends
    add_column :share_friends, :user_sharing_id, :integer
    add_column :share_friends, :user_shared_with_id, :integer
  end
end
