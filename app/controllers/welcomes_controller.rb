class WelcomesController < ApplicationController

  def notify
      @users = User.all.map{|u| (u.dob.strftime('%m').to_i == Date.today.month && u.dob.strftime('%d').to_i == Date.today.day) ? u : nil  if u.dob.present?}.compact
      #@users = User.all.map{|u| u.dob.strftime('%m') == Date.today.month && u.dob.strftime('%d') == Date.today.day  if u.dob.present?}
      render :json => @users
  end

  def index
    if current_user.present?
      @leaves =  current_user.leafe.where(status:STATUS[0])
      @leaves = Kaminari.paginate_array(@leaves).page(params[:page1]).per(2)
      responsible_for = Responsible.responsible_for(current_user.id)
      @leavs = Leave.where('status = ? and user_id IN ( ? )', STATUS[0], responsible_for.map{|r| r.user_id})
      @leavs = Kaminari.paginate_array(@leavs).page(params[:page2]).per(2)
    end
  end
end
