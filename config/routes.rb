FreedomShop::Application.routes.draw do

  resources :media

  get "dashboard/index"
    root to: "dashboard#index"
    
end

