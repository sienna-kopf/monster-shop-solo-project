Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "items#index"

  resources :merchants
  # get "/merchants", to: "merchants#index"
  # get "/merchants/new", to: "merchants#new"
  # get "/merchants/:id", to: "merchants#show"
  # post "/merchants", to: "merchants#create"
  # get "/merchants/:id/edit", to: "merchants#edit"
  # patch "/merchants/:id", to: "merchants#update"
  # delete "/merchants/:id", to: "merchants#destroy"

  resources :items, except: [:new, :create]
  # get "/items", to: "items#index"
  # get "/items/:id", to: "items#show"
  # get "/items/:id/edit", to: "items#edit"
  # patch "/items/:id", to: "items#update"
  # delete "/items/:id", to: "items#destroy"

  resources :merchants do
    resources :items, only: [:index, :new, :create]
  end
  # get "/merchants/:merchant_id/items", to: "items#index"
  # get "/merchants/:merchant_id/items/new", to: "items#new"
  # post "/merchants/:merchant_id/items", to: "items#create"

  resources :items do
    resources :reviews, only: [:new, :create]
  end
  # get "/items/:item_id/reviews/new", to: "reviews#new"
  # post "/items/:item_id/reviews", to: "reviews#create"

  resources :reviews, only: [:edit, :update, :destroy]
  # get "/reviews/:id/edit", to: "reviews#edit"
  # patch "/reviews/:id", to: "reviews#update"
  # delete "/reviews/:id", to: "reviews#destroy"

  get "/cart", to: "cart#show"
  post "/cart/:item_id", to: "cart#add_item"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  resources :orders, only: [:new, :create, :show, :update]
  # get "/orders/new", to: "orders#new"
  # post "/orders", to: "orders#create"
  # get "/orders/:id", to: "orders#show"
  # get "/orders/:id/update", to: "orders#update"

  get "/register/new", to: "users#new"
  post "/register", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/profile", to: "users#show"
  get "/users/edit", to: "users#edit"
  get "/profile/orders", to: "user_orders#index"
  patch "/profile", to: "users#update"

  get "/users/password/edit", to: "passwords#edit"
  patch "/profile/password", to: "passwords#update"

  put "/cart/:item_id/increase", to: "cart#increase"
  put "/cart/:item_id/decrease", to: "cart#decrease"

  namespace :merchant do
    get "/", to: "dashboard#index"

    resources :discounts
    # get "/discounts/new", to: "discounts#new"
    # post "/discounts", to: "discounts#create"
    #
    # get "/discounts", to: "discounts#index"
    # get "/discounts/:discount_id", to: "discounts#show"
    #
    # get "/discounts/:discount_id/edit", to: "discounts#edit"
    # patch "/discounts/:discount_id", to: "discounts#update"
    # delete "/discounts/:discount_id", to: "discounts#delete"
    resources :orders, only: [:show]
    # get "/orders/:order_id", to: "orders#show"

    resources :items, except: [:edit, :show]
    # get "/items", to: "items#index"
    # patch "/items/:id/update", to: "items#update"
    # delete "/items/:id/delete", to: "items#delete"
    # get "/items/new", to: "items#new"
    # post "/items", to: "items#create"

    patch "/orders/:order_id/items/:item_id", to: "order_items#update"
  end

  namespace :admin do
    get "/", to: "dashboard#index"

    resources :users, only: [:index, :show]
    # get "/users", to: "users#index"
    # get "/users/:user_id", to: "users#show"

    resources :orders, only: [:update]
    # patch "/orders/:order_id/update", to: "orders#update"

    resources :merchants, only: [:index, :show, :update]
    # get "/merchants", to: "merchants#index"
    # get "/merchants/:id", to: "merchants#show"
    # patch "/merchants/:id/update", to: "merchants#update"

    resources :users do
      resources :orders, only: [:show]
    end
    # get "/users/:user_id/orders/:order_id", to: "orders#show"
  end
end
