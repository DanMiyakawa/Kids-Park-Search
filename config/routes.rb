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
  # ゲストログイン
  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  namespace :admin do
    get '' => 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :update]
    resources :contacts, only: [:show, :update]
    resources :parks, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:destroy]
      collection do
        get 'search'
      end
    end
  end

  scope module: :public do
    root to: 'homes#top'
    resources :parks do
      collection do
        get 'search'
        get '/prefecture' => "parks#prefecture"
        get '/prefecture/:name' => "parks#prefecture_search", as: 'prefecture_search'
      end
      resources :comments, only: [:create, :destroy] do
        resource :goods, only: [:create, :destroy]
      end
      resource :favorites, only: [:create, :destroy]
    end
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdrawal'
      end
      member do
      get :favorites
      end
    end
    resources :contacts, only: [:index, :new, :create]do
      collection do
      get '/thanks' => 'contacts#thanks'
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
