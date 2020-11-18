Rails.application.routes.draw do
  get 'distance/index'
  devise_for :users
  root to: "users#index"
end
