Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :rooms
  resources :bookings
  root :to => 'bookings#index'
  get 'home' => "bookings#index"
end
