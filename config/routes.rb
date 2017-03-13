Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root "pages#landing"

  resources :courses, only: [:index]
end
