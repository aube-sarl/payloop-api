Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :accounts
      end
      patch "/exchange_rates/update_by_currencies", to: "exchange_rates#update_exchange_rate_by_currencies"
      get "exchange_rates/get_by_currencies", to: "exchange_rates#show_exchange_rate_by_currencies"
      resources :currencies, only: [ :update, :create, :index ]
      resources :exchange_rates, only: [ :create, :update, :show, :index ]
    end
  end
end
