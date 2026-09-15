Rails.application.routes.draw do
  root "pages#home"
  get "visiting", to: "pages#visiting"
  get "about", to: "pages#about"
  
  resources :customers, only: [:index, :show]
  resources :bikes, only: [:index, :show]
  resources :employees, only: [:index, :show]
  resources :services, only: [:index, :show]
  resources :repairs, only: [:index, :show]
end