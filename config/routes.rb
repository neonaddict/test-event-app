Rails.application.routes.draw do
  root 'events#index'
  get    '/admin',   to: 'sessions#new'
  post   '/admin',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'events/:id/ics', to: 'events#ics', as: 'ics_path'

  resources :events, :organizers
end
