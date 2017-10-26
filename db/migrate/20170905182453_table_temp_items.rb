class TableTempItems < ActiveRecord::Migration
  def change
  	create_table :temp_items
    add_column :temp_items, :asin, :string
    add_column :temp_items, :title, :string
    add_column :temp_items, :author, :string
    add_column :temp_items, :price, :string
    add_column :temp_items, :image, :string
    add_column :temp_items, :salesrank, :string
    add_column :temp_items, :url, :string
    add_column :temp_items, :like_id, :integer
  	add_index :temp_items, :like_id 
  end
end
