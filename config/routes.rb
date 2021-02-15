Rails.application.routes.draw do
  get 'my_travel_courses/create'
  get '/model_courses/make_course', to: 'model_courses#make_course'
  post '/my_travel_courses/gone_flag', to: 'my_travel_courses#gone_flag'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_login', to: 'users/sessions#new_guest'
  end
  resources :users
  resources :model_courses
  resources :my_schedules
  resources :course_routes, only: [:show]
  resources :distances, only: [:index]
  resources :my_travel_courses, only: [:show, :edit, :update]
  resources :impressions
  resources :spots do
    resource :wants, only: [:create, :destroy]
  end
  root to: "users#index"
end
