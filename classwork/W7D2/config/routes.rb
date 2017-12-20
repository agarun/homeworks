Rails.application.routes.draw do
  root to: 'static_pages#root'

  namespace :api, defaults: { format: :json } do
    resources :todos, except: [:edit, :new] do
      resources :steps, only: [:create, :update]
    end

    resources :steps, only: [:destroy]
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
