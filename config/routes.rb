Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resource :registration, only: [:new, :create]
  root "pages#home"
  get "visiting", to: "pages#visiting"
  get "about", to: "pages#about"
  
  resources :customers
  resources :bikes
  resources :employees
  resources :services
  resources :repairs
  resources :attachments, only: [:destroy]

  namespace :api do
    namespace :v1 do
      resources :services, only: [:index, :show, :create]
      resources :repairs, only: [:index, :show]
    end
  end
  
end