module Updation
  def change(params)
    if params[:leave][:status] == "Approved"
      available_leave = @leave.user.balance_leave - @leave.no_of_day
      available_leave = 0 if available_leave < 0
      @leave.user.balance_leave = available_leave
      no_of_leaves = @leave.user.no_of_leave + @leave.no_of_day
      @leave.user.no_of_leave = no_of_leaves
      @leave.user.save
      @leave.status ="Approved"
      ResponsibleMailer.leave(@leave.user.email,@leave).deliver
    elsif params[:leave][:status] == "pending" || @leave.status == "Approved"
      @leave.user.balance_leave = @leave.user.balance_leave + @leave.no_of_day
      @leave.user.no_of_leave = @leave.user.no_of_leave - @leave.no_of_day
      @leave.no_of_day = (params[:leave][:end_date].to_date - params[:leave][:start_date].to_date).to_i + 1
      @leave.user.save
    end
  end
end
