Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations' }
  root "pages#landing"

  get :profile, to: "pages#profile"

  resources :users, only: [:update]
  resources :courses, only: [:index]
  resources :requests, only: [:create, :destroy]

  scope :manage do
    get :dashboard, to: "admins#dashboard"
    post :run_assignment_engine, to: "admins#run_assignment_engine"
    post :finalize_all, to: "admins#finalize_all"
    post "finalize/:seminar_id", to: "admins#finalize", as: :finalize
  end
end
