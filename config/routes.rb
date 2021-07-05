Rails.application.routes.draw do
  root to: 'tops#index'
  post 'callback', to: 'line_bot#callback'
  resources :users, only: %i[new]
  resources :terms_of_services, only: %i[index]
  resources :privacy_policys, only: %i[index]
end
