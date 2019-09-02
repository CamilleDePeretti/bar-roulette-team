Rails.application.routes.draw do
  root to: 'nights#new'
  devise_for :users
  root to: 'pages#home'
  resources :nights, only: :create
  get '/:id', to: 'nights#show', as: :night
  patch '/:id', to: 'nights#update', as: :night_update
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
