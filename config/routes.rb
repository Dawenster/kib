Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations' }
  root "pages#landing"

  resources :courses, only: [:index]
end
