Rails.application.routes.draw do

  resources :goals
  resources :users, only: [:create, :new, :index, :show]
  resource :session

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
