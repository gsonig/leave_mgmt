ActiveAdmin.register Responsible do

permit_params :responsible_id, :user_id
index do  
    selectable_column
    column :id
    column "User" do |responsible|
      @user = User.find(responsible.user_id)
      @user.first_name + ' ' + @user.last_name
    end
    column "Responsible" do |responsible|
      @user = User.find(responsible.responsible_id)
      @user.first_name + ' ' + @user.last_name
    end
    actions
  end 
  
 form do |f|
  f.inputs "Create User" do
    f.input :user_id, :as => :select, :collection => User.all.map{|u| ["#{u.first_name} #{u.last_name}", u.id]}
    f.input :responsible_id, :as => :select, :collection => User.all.map{|u| ["#{u.first_name} #{u.last_name}", u.id]}
  end
  f.actions
end
  
 # def show
   # @user = User.find(params[:id])
  #end  

 # def create                        #perform task
   # @responsible=Responsible.new(user_params)

    #if @responsible.save
      #redirect_to @responsible
    #else
     # render 'new'
   # end
 # end  
  action_item do
    link_to 'Invite New User', new_invitation_admin_users_path
  end

end
