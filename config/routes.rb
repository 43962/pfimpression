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
  resources :reviews, only: [:index, :show]
  resources :categories, only: [:index, :create, :edit, :update]
  resources :customers, only: [:index, :show, :destroy]

end

  scope module: :public do
    root 'homes#top'
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update, :destroy]
    resources :reviews, only: [:index, :update, :destroy, :show, :new, :create] do
       resources :comments, only: [:create]
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_scope :customer do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

end
