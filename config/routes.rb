Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks', registrations: 'registrations' }

  resources :books, only: %i[index show] do
    resource :review, only: %i[create]
  end
  resources :orders, only: %i[index show]

  resource :address, only: %i[create update]
  resource :cart, only: %i[show update destroy]
  resource :coupon, only: %i[update]
  resource :checkout, only: %i[show update]

  post '/checkout_sign_up', to: 'checkouts#sign_up'
  post '/checkout_sign_in', to: 'checkouts#checkout_sign_in'

  root to: 'home#index'
end
