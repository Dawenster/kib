Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations' }
  root "pages#landing"

  get :profile, to: "pages#profile"

  resources :courses, only: [:index]
  resources :requests, only: [:create, :destroy]
end
