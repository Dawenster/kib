Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations' }
  root "pages#landing"

  get :profile, to: "pages#profile"

  resources :users, only: [:update]
  resources :courses, only: [:index]
  resources :requests, only: [:create, :destroy]

  get :dashboard, to: "admins#dashboard"
end
