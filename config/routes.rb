Rails.application.routes.draw do
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'admin/index'

  resources :users
  resources :orders
  resources :line_items
  resources :carts
  resources :products do
    get 'who_bought', on: :member
  end

  root "store#index", as: 'store_index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
