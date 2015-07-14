Rails.application.routes.draw do
  root                     "static_pages#home"
  get     "help"       =>   "static_pages#help"
  get     "about"      =>   "static_pages#about"
  get     "contact"    =>   "static_pages#contact"
  get     "signup"     =>   "users#new"
  get     "login"      =>   "sessions#new"
  post    "login"      =>   "sessions#create"
  delete  "logout"     =>   "sessions#destroy"
  resources :categories, only: [:index]
  resources :words, only: [:index]
  resources :users
  resources :lessons
  resources :relationships, only: [:create, :destroy]

  namespace :admin do
    root "users#index"
    resources :users
    resources :categories
    resources :words
  end
end
