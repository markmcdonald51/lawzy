Rails.application.routes.draw do
  resources :term_search_logs
  resources :parts_of_speeches
  resources :terms do
    collection do 
      get :search
      post :search_word
    end 
  end

  resources :dictionaries
  resources :irs_codes
  resources :legals

  root to: "terms#index"
  #mount ActionCable.server => "/cable"

  #root 'dashboard#index'
  root 'admin/dashboard#index'
  get  'admin/dashboard/new_tab'

  get '/login', to: 'static_pages#home'

  # route for logged in user
  get 'profile' => 'users#edit'
  patch 'update_profile' => 'users#update'
  get 'auth/:provider/callback' => 'sessions#create'
  post 'auth/:provider/callback' => 'sessions#create'
  get 'auth/failure' => 'sessions#failure'
  get 'signout' => 'sessions#destroy', as: 'signout'

end
