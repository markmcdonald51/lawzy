Rails.application.routes.draw do
  resources :terms
  resources :dictionaries
  resources :irs_codes
  resources :legals
  root to: "welcome#index"
  root to: "terms#index"
  #mount ActionCable.server => "/cable"
end
