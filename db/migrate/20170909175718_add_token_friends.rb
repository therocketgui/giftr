class AddTokenFriends < ActiveRecord::Migration
  def change
  	add_column :friends, :token_view, :string
  	add_column :friends, :token_share, :string
  end
end
