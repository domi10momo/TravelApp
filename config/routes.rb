Rails.application.routes.draw do
  get 'my_travel_courses/create'
  get 'distance/index'
  devise_for :users
  resources :users
  resources :model_courses
  resources :my_schedules
  resources :my_travel_courses, only: [:index, :create]
  resources :spots do
    resource :wants, only: [:create, :destroy]
  end
  root to: "users#index"
end
