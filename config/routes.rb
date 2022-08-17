Rails.application.routes.draw do
  # get 'users/show/:id', to: "users#show"
  resources :users
  devise_for :users

  resources :posts do
    resources :comments, only: [:create,:destroy]
  end
  resources :likes, only: [:create,:destroy]

  resources :invitation, only: [:index,:new,:create,:destroy]

  root "posts#index"
  get 'all_user',to: "invitation#index"
  post 'accept_invite', to: "invitation#accept"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
