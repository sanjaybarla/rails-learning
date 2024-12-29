Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
  resources :authors
  resources :books
  resources :journals
end
