Rails.application.routes.draw do
  resources :pastorders
  resources :orders
  resources :drinks
  resources :foods
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
