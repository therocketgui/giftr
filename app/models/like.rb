class Like < ActiveRecord::Base
	belongs_to :friend
	has_many :temp_items
end
