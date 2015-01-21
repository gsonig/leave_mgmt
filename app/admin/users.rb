ActiveAdmin.register User do
  actions :all, :except => [:edit,:new]
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end  
  index do  
    column :id
    column :first_name
    column :last_name
    column :gender
    column :dob
    column :mobile
    column :family_member_mobile
    column :email
    column :address
    actions
  end 
  
  form do |f|
    f.inputs "Create User" do
      f.input :first_name
      f.input :last_name
      f.input :gender
      f.input :dob
      f.input :mobile
      f.input :family_member_mobile
      f.input :email
      f.input :password
      f.input :address
      end
    f.actions
  end
  
  action_item do
    link_to 'Invite New User', new_invitation_admin_users_path
  end
 
  collection_action :new_invitation do
    @user = User.new
  end
  
  show  do
    attributes_table do
      row :id
      row :email
      row :first_name
      row :last_name
      row :gender
      row :dob
      row :mobile
      row :family_member_mobile
      row :address
      row :iamge
    end
  end
 
  # def create                        #perform task
  #   @user=User.new(user_params)
  #   if @user.save
  #     redirect_to @user
  #   else
  #     render 'new'
  #   end
  # end  

 
  collection_action :send_invitation, :method => :post do
    @user = User.invite!(params.require(:user).permit(:first_name, :last_name, :email , :invitation_token))
 
    @user.add_role params[:user][:role][:name]
    if @user.errors.empty?
      flash[:success] = "User has been successfully invited."
      redirect_to admin_root_path
    else
      messages = @user.errors.full_messages.map { |msg| msg }.join
      flash[:error] = "Error: " + messages
      redirect_to admin_root_path
    end
  end
  
  filter :first_name
  filter :last_name
  filter :gender
  filter :dob
  filter :mobile
  filter :family_member_mobile
  filter :email
  filter :address
end
