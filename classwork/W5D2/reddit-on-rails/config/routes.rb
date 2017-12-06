Rails.application.routes.draw do
  get 'comments/new'

  get 'comments/create'

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :comments, only: [:create, :show]
  resources :posts, except: [:index] do
    resources :comments, only: [:new]
  end
end
