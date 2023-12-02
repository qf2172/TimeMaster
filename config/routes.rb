Rails.application.routes.draw do
  # User routes
  resources :users
  
  # Session routes for login and logout
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Task routes
  resources :tasks do
    member do
      get 'manual_delete'
    end
  end

  # Set the root route
  root 'sessions#new'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end