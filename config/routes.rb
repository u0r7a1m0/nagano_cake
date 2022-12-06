Rails.application.routes.draw do

  
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :items, :genres, :customers, :order_details, :order
  end
  namespace :pablic do
    resources :items, :customers, :cart_items, :orders, :addresses
  end
  
  root 'pablic/homes#top'
  # get 'pablic/homes#about'
  
  # get 'pablic/customers/my_page#show' => '/customers/my_page'
  # get 'pablic/customers/information#edit' => '/customers/information'

  # get "homes/about" => "homes#about", as: "about"
  

  # resources :items, only: [:new, :create, :index, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
