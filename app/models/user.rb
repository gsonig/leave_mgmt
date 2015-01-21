class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  GENDER = ['Male', 'Female']
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :leafe , :class_name => "Leave", :dependent => :destroy
  has_many :responsibles, :dependent => :destroy    
  scope :get_users, lambda{|id| where(:id => id)}
  before_create :default_value
  
  def default_value
		self.balance_leave ||= MONTHS[Time.now.month.to_s]
  end
end
