class Leave < ActiveRecord::Base
  belongs_to :user
  include Mailer
  validates :subject, presence:true,length: { minimum: 5}
  validates_presence_of :start_date, :end_date
  scope :this_months_leave, lambda { |date| where("start_date >= ? AND start_date <= ?", 
  date.beginning_of_month, date.end_of_month) }
  before_create :set_values
  after_destroy :update_user_leave
  after_create :send_email 
  after_update :leave_update
  max_paginates_per 5
 
 	def set_values
		hour = (self.end_date-self.start_date)/3600
		no_of_day = 0.0
		if hour < 24
			no_of_day = hour/9
		else	
			while (hour>=24)
				hour = hour-15  				
			end
			no_of_day = hour/9
		end				
    self.no_of_day ||= no_of_day
	end

 	def send_email
 		email(self.user,self)
 	end

 	def leave_update
		if self.status == 'Approved'
	    	available_leave = self.user.balance_leave - self.no_of_day
		    self.user.balance_leave = available_leave
		    no_of_leaves = self.user.no_of_leave + self.no_of_day
		    self.user.no_of_leave = no_of_leaves
		    self.user.save
			ResponsibleMailer.leave(self.user.email,self).deliver 				
		end		
 	end
	
	# def update_user_leave
	# 	self.user.no_of_leave = self.user.no_of_leave - self.no_of_day
	# 	self.user.balance_leave = self.user.balance_leave + self.no_of_day	
	# 	self.user.save	
	# end	

	def self.leaves(user)
		if user.has_role? :hr
	    @holiday = Leave.where(status: "pending")
	  else
      count = 0
      @holiday = Array.new
      users = Responsible.responsible_for(user.id)
      users.each do |user|
      	@pending_leaves = Leave.where(user_id: user.user_id, status: "pending")
      	@all_leaves = Leave.where(user_id: user.user_id) 
      	@pending_leaves.each do |pending_leave|
     			@holiday[count] = pending_leave
        		count = count + 1       
      	end
   		end
    end
  end
	
	def self.leave_Search(user,parameter)
		if parameter[:q1].blank?
			user.leafe.page(parameter[:page])		
		else
			user.leafe.where('DATE(leaves.start_date) BETWEEN ? AND ?',"#{parameter[:q1]}","#{parameter[:q2]}").page(parameter[:page])
		end	
	end		

	def self.user_under_responsible_leave(user)
		count = 0
  	@holiday = Array.new
  	users = Responsible.responsible_for(user.id)
  	users.each do |user|
    	@leaves = Leave.where(user_id: user.user_id)
	  	@leaves.each do |leave|
	  		@holiday[count] = leave
	  		count = count + 1 	      
	  	end 
	  end
	end
end
