Rails.application.routes.draw do
  root 'events#index'
  get    '/admin',   to: 'sessions#new'
  post   '/admin',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :events do
    get :ics, on: :member
    post :subscribe, on: :member
    get :filter, on: :collection
  end
  resources :organizers
end
