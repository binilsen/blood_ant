# frozen_string_literal: true

Rails.application.routes.draw do
  scope 'api/v1' do
    post 'sign_in', to: 'sessions#create'
    post 'sign_up', to: 'registrations#create'
    resources :sessions, only: %i[index show destroy]
    resource  :password, only: %i[edit update]
    namespace :identity do
      resource :email,              only: %i[edit update]
      resource :email_verification, only: %i[show create]
      resource :password_reset,     only: %i[new edit create update]
    end
  end
  namespace :api do
    namespace :v1 do
      resources :logs do
        get :filters, on: :collection
        get :active, on: :collection
        post :generate_report, on: :collection
      end

      resources :profile do
        get :active_dose, on: :collection
      end
      resources :doses
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
