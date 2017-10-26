class TableAddIconToFriend < ActiveRecord::Migration
  def change
  	add_column :friends, :icon, :string
  end
end
