Rails.application.routes.draw do
  root to: 'tops#index'
  resources :users, only: %i[new]
  resources :wastings, only: %i[create]
  resources :terms_of_services, only: %i[index]
  resources :privacy_policys, only: %i[index]
end
