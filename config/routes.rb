Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :home, only: [:index]
  resources :products, only: [:index, :show]
  resources :cart, only: [:index] do
    collection do
      post :add
    end
    member do
      delete :remove
    end
  end
  resources :orders, only: [:index, :show, :create] do
    member do
      post :set_delivery_detail
    end
  end

  resources :payments, only: [:index, :new] do
    collection do
      post :pay_now
      post :pay_on_delivery
    end
  end

  root 'home#index'
  get "/*path", to: 'home#index'
end
