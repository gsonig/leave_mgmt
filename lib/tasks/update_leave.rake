namespace :update_leave do
  desc "TODO"
  task balance_leave: :environment do
  	User.all.each do |user|	  
			user.balance_leave = 0 if user.balance_leave < 0
			user.balance_leave = user.balance_leave + MONTHS[Time.now.month.to_s]						
			user.save 
		end
	end
end
