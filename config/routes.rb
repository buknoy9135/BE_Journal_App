Rails.application.routes.draw do
  get "errors/not_found"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "categories#index"
  resources :categories do
    resources :tasks do
      member do
        patch :toggle_complete
      end
    end
  end

  # for error handling of routes
  match "*unmatched", to: "errors#not_found", via: :all
end
