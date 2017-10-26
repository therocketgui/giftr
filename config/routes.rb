Rails.application.routes.draw do

  get 'temp_items/index'

  get 'items/index'

  #devise_for :users
  
  devise_scope :user do
    get "/register" => "devise/registrations#new", as: "new_user_registration" # Helpers might not work with this?
    get "/register/:alert/:token_share" => "devise/registrations#new", as: "new_user_registration_alert" # Helpers might not work with this?
  end
  devise_for :users, controllers: { sessions: 'users/sessions' }, skip: [:sessions]
    as :user do
      get 'login', to: 'devise/sessions#new', as: :new_user_session
      post 'login', to: 'devise/sessions#create', as: :user_session
      delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
    end

  get 'pages/home'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'pages#home'
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  get '/friends' => 'friends#index'
  get '/friends/:id' => 'friends#show'
  get '/friends/:id/item/:asin' => 'friends#show'

  post '/friends' => 'friends#create'
  patch '/friends' => 'friends#update'
  delete '/friends' => 'friends#destroy'

  post 'likes' => 'likes#create'
  patch 'likes/:id' => 'likes#update'
  delete 'likes' => 'likes#destroy'

  get '/wish/:id' => 'friends#wish'
  get '/wish/:id/item/:item_id' => 'friends#wish'

  get '/view/:token_view' => 'friends#view'
  get '/share/:token_share' => 'friends#share'
  get '/share/add/:token_share' => 'share_friends#create'

  post 'items' => 'items#create'
  post 'items' => 'items#create_modal'
  patch 'items/:id' => 'items#update'
  delete 'items' => 'items#destroy'

  post 'comments' => 'comments#create'
  patch 'comments' => 'comments#update'
  delete 'comments' => 'comments#destroy'

  post 'loves' => 'loves#create'
  patch 'loves' => 'loves#update'
  delete 'loves' => 'loves#destroy'

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
