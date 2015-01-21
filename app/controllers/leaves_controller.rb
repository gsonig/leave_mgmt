class LeavesController < ApplicationController
  #before_filter :find_post, :only => [:accept]   
  include Updation
  before_filter :authenticate_user!
  def new
    @leave = Leave.new
  end

  def create    
    @leave = current_user.leafe.create(leave_params)
    redirect_to root_path
  end

  def index
    @leaves = Leave.all.page(params[:page])
  end

  def show
    @leave = Leave.find(params[:id]) 
    render :layout => false
  end

  def edit
    @leave = Leave.find(params[:id])
  end  

  def update
    @leave = Leave.find(params[:id]) 
    @leave.update_attributes(leave_params)
    redirect_to leave_leaves_path 
  end 
  
  def leave
    @leaves = Leave.leave_Search(current_user,params)
  end
  
  def destroy
    leave = Leave.find(params[:id])
    leave.destroy
    redirect_to leave_leaves_path   
  end  

  def leave_comment
    @leave = Leave.find(params[:leafe_id])
  end

  private
    def leave_params
      params.require(:leave).permit(:subject, :start_date, :end_date, :comment, :user_id, :leave_comment, :status, :day, :timing)
    end
end