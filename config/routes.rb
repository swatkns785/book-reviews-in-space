Rails.application.routes.draw do
  devise_for :users
  root to: 'books#index'

  resources :books, only: [:new, :index, :create, :show] do
    resources :reviews, only: [:new, :create, :edit, :update]
  end
end
