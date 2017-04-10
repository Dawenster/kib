Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations' }
  root "pages#landing"

  get :contact, to: "pages#contact"

  resources :users, only: [:update]
  resources :courses, only: [:index]
  resources :requests, only: [:index, :create, :destroy]

  get :classes, to: "seminars#index"
  get "classes/:seminar_id/edit", to: "seminars#edit", as: :edit_class
  resources :seminars, only: [:update] do
    member do
      patch :upload_file_to_dropbox
    end
  end

  scope :manage do
    get :dashboard, to: "admins#dashboard"
    post :run_assignment_engine, to: "admins#run_assignment_engine"
    post :finalize_all, to: "admins#finalize_all"
    post "finalize/:seminar_id", to: "admins#finalize", as: :finalize
  end
end
