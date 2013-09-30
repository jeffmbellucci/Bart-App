BartApp::Application.routes.draw do
  resources :stations, only: [:index, :show]
  resources :users ,only: [:create, :update, :destroy]
  resources :reminders, only: [:index, :create, :destroy]
  resources :closest_stations, only: [:create]
  resource :sessions, only: [:new, :create, :destroy]
  
  root to: "stations#index"
  
end
  
  