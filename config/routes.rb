Rails.application.routes.draw do
  
  root 'pages#index'
  #get 'pages/index'
  resources :users
end
