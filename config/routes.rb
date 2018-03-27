Rails.application.routes.draw do
  root 'events#index'
  get    '/admin',   to: 'sessions#new'
  post   '/admin',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :events, :organizers
end
