class LeavesController < ApplicationController
  #before_filter :find_post, :only => [:accept]
  before_filter :authenticate_user!
  def new
    @leave = Leave.new
  end

  def create
    params[:leave][:start_date] =  Date.strptime( params[:leave][:start_date], "%m/%d/%Y") unless params[:leave][:start_date].blank?
    params[:leave][:end_date] =  Date.strptime( params[:leave][:end_date], "%m/%d/%Y") unless params[:leave][:end_date].blank?
    @leave = Leave.new(leave_params)
      user = current_user
        responsible_users = user.responsible.map{|r| r.responsible_id}
        if responsible_users.present?
             responsible_users = User.get_users(responsible_users)
                 if @leave.save
                    redirect_to  new_leafe_path
                      responsible_users.each do |responsible_user|
                        ResponsibleMailer.leave(responsible_user,@leave).deliver
                        end
                    else
                      render 'new'
                  end
        else
            render 'new'
        end   
    end

      def index
        @responsible_for = Responsible.responsible_for(current_user.id)
        if params[:beginning_of_month].blank?
          @leaves = Leave.this_months_leave(Date.current).where(' user_id IN ( ? )', @responsible_for.map{|r| r.user_id}.push(current_user.id))
          session['month'] = Date.current.beginning_of_month
        else
          @leaves = Leave.this_months_leave(params[:beginning_of_month].try(:to_date)).where(' user_id IN ( ? )', @responsible_for.map{|r| r.user_id}.push(current_user.id))
          session['month'] = params[:beginning_of_month].try(:to_date)
        end
      # @date = params[:month] ? Date.parse(params[:month]) : Date.today
      end
      def show
        @leave = Leave.find(params[:id]) 
         render :layout => false
      end

      def update
          @leave = Leave.find(params[:id]) 
        	if @leave.status == STATUS[0]
        	  respond_to do |format|
        	    if @leave.update_attributes(leave_params)
        	      user = @leave.user
        	      ResponsibleMailer.leave(user,@leave).deliver
                      @leaves =  current_user.leafe.where(status:STATUS[0])
                        @leaves = Kaminari.paginate_array(@leaves).page(params[:page1]).per(2)
                          responsible_for = Responsible.responsible_for(current_user.id)
                            @leavs = Leave.where('status = ? and user_id IN ( ? )', STATUS[0], responsible_for.map{|r| r.user_id})
                              @leavs = Kaminari.paginate_array(@leavs).page(params[:page2]).per(2)
                   format.js
        	    #  format.html { render '/welcomes/index', :content_type => 'text/html'}
        	    else
        	      format.html { render 'leave_comment'}
        	    end
        	  end
        	else
        	   flash.now[:error] = 'This Leave Is Already Updated'
        	end
      end 

      def leave_comment
          @leave = Leave.find(params[:leafe_id])    
      end

      private
        def leave_params
            params.require(:leave).permit(:subject, :start_date, :end_date, :comment, :user_id, :leave_comment, :status)
        end
end
