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
  ###################################
  root to: 'public/homes#top'


  # 会員側のルーティング設定
  ## URLの「public」部分なしのができる！
  scope module: :public do
    ## 取得できるアクションがメジャーなやつだけなのでイレギュラーのアクションは「GET」で指定する必要がある！
    get '/about' => 'homes#about'
    ## URLが違うものになるものは「get」などで一つずつ指定してあげる！

    # 「customers」
    get '/customers/my_page' => 'customers#show', as: 'my_page'
    get '/customers/information/edit' => 'customers#edit', as: 'customers_edit'
    patch '/customers/information' => 'customers#update', as: 'information'
    get '/customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw'

    # 「Cart_items」
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'

    # 「Orders」
    post '/orders/confirm' => 'orders#confirm', as: 'confirm'
    get '/orders/complete' => 'orders#complete', as: 'complete'

    resources :items, :cart_items, :orders, :addresses
  end
  #####################
  # 管理者側のルーティング設定
  ## URLの頭に「admin」入れる設定
  namespace :admin do
    root to: 'homes#top'
    resources :items, :customers, :genres, :orders, :order_details

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
