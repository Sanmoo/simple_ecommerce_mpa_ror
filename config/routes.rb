# frozen_string_literal: true

Rails.application.routes.draw do
  resources :shopping_cart_items, only: %i[create index]
  resources :orders, only: %i[new]
  patch 'shopping_cart_items/update', to: 'shopping_cart_items#update'
  delete 'shopping_cart_items/delete', to: 'shopping_cart_items#delete'

  resources :products
  devise_for :users
  get 'home/show'
  root 'home#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
