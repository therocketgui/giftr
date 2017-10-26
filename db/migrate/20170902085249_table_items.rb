class TableItems < ActiveRecord::Migration
  def change
  	create_table :items
    add_column :items, :asin, :string
    add_column :items, :title, :string
    add_column :items, :author, :string
    add_column :items, :price, :string
    add_column :items, :image, :string
    add_column :items, :salesrank, :string
    add_column :items, :friend_id, :integer
  	add_index :items, :friend_id 
  end
end
