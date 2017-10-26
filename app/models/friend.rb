class Friend < ActiveRecord::Base
	belongs_to :user
	has_many :likes
	has_many :items
	has_many :share_friends

	validates :token_view, presence: true
	validates :token_view, uniqueness: true

	validates :token_share, presence: true
	validates :token_share, uniqueness: true

	before_validation :generate_token_view, on: :create
	before_validation :generate_token_share, on: :create

	before_create :generate_icon

	def generate_token_view
	  begin
	    self.token_view = SecureRandom.hex(10)
	  end while self.class.find_by(token_view: token_view)
	end

	def generate_token_share
	  begin
	    self.token_share = SecureRandom.urlsafe_base64(32, false)
	  end while self.class.find_by(token_share: token_share)
	end

	def to_param
	  token_view
	  token_share
	end

	def generate_icon
		r = Random.new
		icon_id = r.rand(1...50)
	    self.icon = "icon-#{icon_id}.png"
	end
end
