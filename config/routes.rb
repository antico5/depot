Rails.application.routes.draw do
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'admin/index'

  resources :users
  resources :products do
    get 'who_bought', on: :member
  end

  scope '(:locale)' do
    resources :carts
    resources :line_items
    resources :orders
    root "store#index", as: 'store_index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
