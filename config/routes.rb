# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root 'main#index'
  get 'contacts', to: 'main#contacts'
  get 'shop', to: 'categories#shop'
  get 'search', to: 'products#search'
  get 'storehouses/search', to: 'storehouses#search'
  get 'my_cart', to: 'carts#my_cart'
  post 'add_to_cart', to: 'carts#add_to_cart'
  post 'remove_from_cart', to: 'carts#remove_from_cart'
  post 'minus_one_item', to: 'carts#minus_one_item'
  post 'plus_one_item', to: 'carts#plus_one_item'
  get 'user_profile', to: 'main#user_profile'

  resources :categories
  resources :products, except: :destroy
  resources :storehouses, except: :show
  resources :carts, only: :destroy
  resources :delivery_addresses, except: %i[index show]
  resources :payment_cards, except: %i[index show]
  resources :orders, except: :destroy

  authenticated :user do
    mount MissionControl::Jobs::Engine, at: '/jobs'
  end
end
