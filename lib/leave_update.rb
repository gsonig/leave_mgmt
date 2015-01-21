module LeaveUpdate
	def update_leave(leave)
		user = leave.user			
		unless leave.status == 'Decline'     
      available_leave = user.balance_leave - leave.no_of_day
      available_leave = 0 if available_leave < 0
      user.balance_leave = available_leave
      no_of_leaves = user.no_of_leave + leave.no_of_day
      user.no_of_leave = no_of_leaves
      user.save
			ResponsibleMailer.leave(user,leave).deliver
    end
	end
end
