class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  #attr_accessible :first_name, :last_name
  #validates_presence_of :first_name, :last_name

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :friends
  has_many :comments
end
