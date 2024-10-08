Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :plants do
    resources :rentings, only: [:create]
  end
  resources :rentings, only: [:show, :destroy] do
    member do
      patch :accept
      patch :deny
    end
  end
  get "/dashboard", to: "pages#dashboard", as: "dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
