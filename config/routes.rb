Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [ :index, :show, :create, :update, :destroy ]
      resources :currencies, only: [ :index, :update, :show, :destroy, :create ]
      resources :users, only: [ :index, :show, :create, :update, :destroy ] do
        resources :accounts, only: [ :index, :create, :destroy, :update, :show ]
        resources :transactions, only: [ :index, :create, :update, :show ]
      end
    end
  end
end
