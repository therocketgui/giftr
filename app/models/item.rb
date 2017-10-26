class Item < ActiveRecord::Base
	belongs_to :friend
	has_many :comments
	has_many :loves
end
