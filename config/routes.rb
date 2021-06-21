Rails.application.routes.draw do
  get 'tops/index'
  post 'callback', to: 'line_bot#callback'
end
