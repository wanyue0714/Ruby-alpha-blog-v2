Rails.application.routes.draw do
  # get 'pages/home', to: 'pages#home'
  root 'pages#home'
  # get 'pages/about', to: 'pages#about'
  get 'about', to: 'pages#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles
end