TheMarketingCalendar::Application.routes.draw do
  get "get_going/start"
  get "get_going/home_biz"
  get "get_going/small_biz"
  get "get_going/medium_biz"
  get "get_going/large_biz"
  get "get_going/twitter_add"
  get "get_going/facebook_add"
  get "get_going/event_add"
  post "get_going/create_event"
  
  devise_for :users, path_names: { :sign_in => "login", :sign_out => "logout" }
  get "calendar_share/choose_calendar"
  get "calendar_share/choose_user"

  get "calendar/index"
  get "calendar/events"

  match '/update_hidden_category_flag/:id',  to: 'calendar#update_hidden_category_flag',    via: 'get'

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/interested', to: 'static_pages#interested',     via: 'post'
  
  get 'edit_event_in_popover/:id/edit' => 'events#edit_event_in_popover', as: :edit_in_po
  get 'new_event_in_popover' => 'events#new_event_in_popover', as: :new_in_po

  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
  match '/choose-calendar-to-share',  to: 'calendar_share#choose_calendar',         via: 'get'
  match '/choose-person-to-share',    to: 'calendar_share#choose_user',             via: 'post'
  match '/share-calendars',           to: 'calendar_share#share_calendars',         via: 'post'
  match '/share-calendars',           to: 'calendar_share#share_calendars_signup',  via: 'get'
  match '/calendar-reminder',         to: 'calendar#stakeholder_interest',          via: 'post'
  
  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  get "static_pages/contact"

  resources :events

  resources :categories
  resources :category_groups

  resources :campaigns

  resources :users

  resources :companies

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'

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
