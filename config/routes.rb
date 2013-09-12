BartApp::Application.routes.draw do
  resources :stations, only: [:index, :show]
  resources :users#,only: [:new, :show]
  resource :sessions, only: [:new, :create, :destroy]
  
  root to: "stations#index"
  
  match "/all_stations", to: "static_pages#all_stations"
  match "/about", to: "static_pages#help"
  match "/contact", to: "static_pages#contact"
  match "/help", to: "static_pages#help"
end
  
  