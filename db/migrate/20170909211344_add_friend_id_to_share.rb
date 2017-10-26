class AddFriendIdToShare < ActiveRecord::Migration
  def change
  	add_column :share_friends, :friend_id, :integer
  end
end
