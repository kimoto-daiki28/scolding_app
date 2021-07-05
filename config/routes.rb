Rails.application.routes.draw do
  root to: 'tops#index'
  resources :users, only: %i[new]
  resources :wastings, only: %i[create]
end
