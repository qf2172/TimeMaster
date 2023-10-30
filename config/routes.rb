Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :tasks
  resources :tasks do
    member do
      get 'manual_delete'
    end
  end
  root 'tasks#index'
end
