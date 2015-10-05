Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  resources :scrapers, only: [:index, :new, :show]
end
