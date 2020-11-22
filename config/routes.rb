Rails.application.routes.draw do
  get 'distance/index'
  devise_for :users
  resources :model_courses
  root to: "users#index"
end
