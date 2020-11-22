Rails.application.routes.draw do
  get 'distance/index'
  devise_for :users
  resources :users
  resources :model_courses
  resources :spots do
    resource :wants, only: [:create, :destroy]
  end
  root to: "users#show"
end
