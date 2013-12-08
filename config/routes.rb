FreedomShop::Application.routes.draw do

  resources :people

  resources :sessions

  get "users/new"
  resources :media

  get "logout" => 'sessions#destroy'

  get "dashboard/index"
  root to: "media#index"
    
end

