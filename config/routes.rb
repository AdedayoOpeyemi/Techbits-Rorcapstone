Rails.application.routes.draw do
  root 'techbits#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/users/:id/follow', to: 'users#follow', as: 'follow_user'
  post '/users/:id/unfollow', to: 'users#unfollow', as: 'unfollow_user'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'

  resources :users, except: [:index]
  resources :techbits, except: %i[destroy edit update]
end
