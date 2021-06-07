Rails.application.routes.draw do

  post "users/create" => "users#create"
  post "users" => "users#account_update"
  get "users/account" => "users#account"
  get "users/edit" => "users#edit"
  post "users/update" => "users#profile_update"
  get "users/profile" => "users#profile"
  get "signup" => "users#new"
  post "login" => "users#login"
  delete "logout" => "users#logout"
  get "login" => "users#login_form"
  
  get "reservations" => "reservations#index"
  get "reservations/new" => "reservations#new"
  post "reservations/create" => "reservations#create"
  get "reservations/:id" => "reservations#show"
  
  get "rooms/new" => "rooms#new"
  post "rooms/create" => "rooms#create"
  get "rooms/search" => "rooms#search"
  get "rooms/posts" => "rooms#posts"
  get "rooms/:id" => "rooms#show"

  get "/" => "home#top"
end
