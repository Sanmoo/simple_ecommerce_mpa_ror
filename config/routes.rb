# frozen_string_literal: true

Rails.application.routes.draw do
  resources :shopping_cart_items, only: :create
  resources :products
  devise_for :users
  get 'home/show'
  root 'home#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
