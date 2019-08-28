Rails.application.routes.draw do
  root to: 'nights#new'
  devise_for :users
  root to: 'pages#home'
  resources :nights, only: [:create, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
