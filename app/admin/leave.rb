ActiveAdmin.register Leave do
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
    column "User" do |leave|  
      @user = User.find(leave.user_id)
      @user.first_name
    end
    column :subject
    column :comment
    column :start_date
    column :end_date
    column :status
    column :no_of_day
    actions
  end  
  # form do |f|
  #   f.inputs "Create User" do
  #     f.input :subject, :as => :select, :collection => User.all.map{|u| ["#{u.first_name} #{u.last_name}", u.id]}
  #     f.input :comment, :as => :select, :collection => User.all.map{|u| ["#{u.first_name} #{u.last_name}", u.id]}
  #     f.input :start_date
  #     f.input :end_date
  #     f.input :status
  #     f.input :no_of_day  
  #   end
  # end

  # show do |leave|
  #   columns do column do attributes_table do row :id row :user end end 

  # end  
end