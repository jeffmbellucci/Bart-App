BartApp::Application.routes.draw do
  resources :stations, only: [:index, :show]
  resources :users#,only: [:new, :show]
  resources :reminders, only: [:create, :destroy]
  resource :sessions, only: [:new, :create, :destroy]
  
  root to: "stations#index"
  
  get "/all_stations", to: "static_pages#all_stations"
  get "/about", to: "static_pages#help"
  get "/contact", to: "static_pages#contact"
  get "/help", to: "static_pages#help"
 
end
  
  