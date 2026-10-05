Rails.application.routes.draw do
  root "pages#home"
  get "visiting", to: "pages#visiting"
  get "about", to: "pages#about"
  
  resources :customers
  resources :bikes
  resources :employees
  resources :services
  resources :repairs
  resources :attachments, only: [:destroy]
end