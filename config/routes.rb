Rails.application.routes.draw do
  root to: 'tops#index'
  post 'callback', to: 'line_bot#callback'
  resources :users, only: %i[create]
end
