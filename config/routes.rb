Rails.application.routes.draw do
  get 'my_travel_courses/create'
  get 'distance/index'
  devise_for :users
  resources :users
  resources :model_courses
  resources :my_schedules
  resources :distances, only: [:index]
  resources :my_travel_courses, only: [:show, :edit, :update]
  resources :spots do
    resource :wants, only: [:create, :destroy]
  end
  root to: "users#index"
end
