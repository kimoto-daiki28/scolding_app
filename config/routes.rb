Rails.application.routes.draw do
  get 'usages/index'
  root to: 'tops#index'
  resources :users, only: %i[new destroy]
  resources :wastings, only: %i[create show edit update destroy]
  resources :terms_of_services, only: %i[index]
  resources :privacy_policys, only: %i[index]
  resources :usages, only: %i[index]
  resource  :my_page, only: %i[show]
end
