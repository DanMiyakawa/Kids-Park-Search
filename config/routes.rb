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
    resources :genres, only: [:index, :create, :edit, :update]
  end
  
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resources :parks do
      resource :favorites, only: [:create, :destroy]
    end
    resources :customers, only: [:show,:edit,:update] do
      collection do
        get 'unsubscribe'
        patch 'withdrawal'
      end
      member do
      get :favorites
      end
    end
    resources :contacts, only: [:index,:new,:create]do
      collection do
      get '/thanks' => 'contacts#thanks'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
