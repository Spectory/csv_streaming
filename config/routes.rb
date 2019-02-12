Rails.application.routes.draw do
  get '/robots.txt', to: 'application#robots'

  root 'application#index'
  post 'export', to: 'export#export'
end
