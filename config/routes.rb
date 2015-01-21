Rails.application.routes.draw do
  
  root 'welcomes#index'
  resources :leaves   do
    get 'accept'
    get 'decline'
    get 'leave_comment'
		get 'leave', :on => :collection		
  end

  #resources :users do
  #  resources :invitations, :controller => "users/invitations"
  #end
 
  #resources :users, :except => :new
  
  get "/welcome_notify",  to: "welcomes#notify"
	get "/show_responsible", to: "welcomes#responsible"
	get "/approval_leave", to: "welcomes#approval_leave"
	get "/employer_leaves", to: "welcomes#employer_leave"
  devise_for :users, :controllers => {
      :invitations => 'users/invitations' # user_invitations_controller.rb
      }, :skip => [:registrations]
      as :user do
        get   'users/cancel' => 'devise_invitable/registrations#cancel' , :as => 'cancel_user_registration'
        post  'users' => 'devise_invitable/registrations#create' , :as => 'user_registration'
        get   'users/edit' => 'devise_invitable/registrations#edit' , :as => 'edit_user_registration'
        patch 'users' => 'devise_invitable/registrations#update'
        put   'users' => 'devise_invitable/registrations#update'
        delete 'users' => 'devise_invitable/registrations#destroy'
      end
      
 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
    
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
