BartApp::Application.routes.draw do
  resources :stations, only: [:index, :show]
  resources :users ,only: [:create, :update, :destroy]
  resources :reminders, only: [:index, :create, :destroy]
  resources :closest_stations, only: [:create]
  resource :sessions, only: [:new, :create, :destroy]
  
  
  root to: "stations#index"
  
  get "/all_stations", to: "static_pages#all_stations"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/help", to: "static_pages#help"
 
end
  
  