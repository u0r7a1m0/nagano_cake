Rails.application.routes.draw do

  devise_for :admins
  devise_for :customers
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
  ###################################

    # 会員側のルーティング設定
  root to: 'homes#top'


    # 管理者側のルーティング設定
  namespace :admin do
    resources :items, :customers, :genres, :homes, :orders
    get 'admin/homes#top' => 'admin/homes#top'

  end



  # resources :items, only: [:new, :create, :index, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
