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

  resources :reviews, only: [:index, :show, :destroy] do
    resources :comments, only: [:destroy]
  end
  resources :categories, only: [:index, :create, :edit, :update, :destroy]
  resources :customers, only: [:index, :show, :destroy]

end

  scope module: :public do
    root 'homes#top'
    get '/about' => 'homes#about'
    get '/unsubscribe' => 'customers#unsubscribe'
    patch '/withdraw' => 'customers#withdraw'
    resources :categories, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw] do
      member do
        get 'favorites'
      end
    end

    resources :reviews, only: [:index, :update, :destroy, :show, :new, :create, :edit,] do
      #下書き一覧
      collection do
       get 'draft_index'
      end
       resources :comments, only: [:create, :destroy]
       resource :favorites, only: [:create, :destroy]
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

end
