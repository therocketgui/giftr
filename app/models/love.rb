class Love < ActiveRecord::Base
	belongs_to :item

	before_create :current_date

	def current_date
	    self.date = Time.now
	end
end
