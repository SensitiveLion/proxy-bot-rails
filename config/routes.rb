Rails.application.routes.draw do
  root 'schedules#index'
  devise_for :users

  resources :schedules, except: :new
end
