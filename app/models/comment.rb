class Comment < ActiveRecord::Base
	belongs_to :item
	belongs_to :user

	before_create :current_date

	def current_date
	    self.date = Time.now
	end
end
