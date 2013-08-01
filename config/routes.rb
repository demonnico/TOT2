TOT2::Application.routes.draw do
  devise_for :users

  # download
  root :to => 'download#index'
  get "download/index"
  match 'download/ipa/:version_id', :to => 'download#downipa'
  match 'download/dsym/:version_id', :to => 'download#downdsym'


  # app admin
  match 'admin', :to => 'app#apps'
  match 'admin/index', :to => 'app#apps'
  match 'admin/apps', :to => 'app#apps'
  match 'admin/apps/:app_id/delete', :to => 'app#deleteapp'
  match 'admin/apps/:app_id/versions', :to => 'app#versions'
  
  # upload
  match 'admin/upload', :to => 'upload#upload'

  # users admin
  match 'admin/users', :to => 'user#users'
  match '/admin/users/:user_id/changerole/:role', :to => 'user#changerole'
  match '/admin/users/:user_id/delete', :to => 'user#delete'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
