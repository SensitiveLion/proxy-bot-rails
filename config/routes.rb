Rails.application.routes.draw do
  root 'schedules#index'
  devise_for :users

  resources :schedules, only: [:index, :create]
  resources :scraper
end
