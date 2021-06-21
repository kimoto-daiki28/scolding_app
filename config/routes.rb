Rails.application.routes.draw do
  root to: 'tops#index'
  post 'callback', to: 'line_bot#callback'
end
