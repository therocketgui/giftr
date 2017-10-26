class TableLove < ActiveRecord::Migration
  def change
  	create_table :loves
    add_column :loves, :asin, :string
    add_column :loves, :user_id, :string
    add_column :loves, :date, :string
    add_column :loves, :friend_id, :integer
    add_column :loves, :item_id, :integer
  	add_index :loves, :item_id 
  end
end
