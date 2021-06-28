Rails.application.routes.draw do
  namespace :api do 
    resources :users, only: [:create, :show]
    match '/user', to: 'users#show', via: [:get]
    resources :games, only: [:index]
    match '/sessions', to: 'sessions#login', via: [:post]
    match '/user/game_events', to: 'game_events#create', via: [:post]
  end
end
