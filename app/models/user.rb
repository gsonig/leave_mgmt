class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  GENDER = ['Male', 'Female']
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   has_many :leafe , :class_name => "Leave"
   has_many :responsible, :dependent => :destroy  
  scope :get_users, lambda{|id| where(:id => id)}
end
