EtudePepinet::Application.routes.draw do
  root to: 'page#show'
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :news, path: '/actualites'

  resource :book_orders, path: '/livres', only: [:show, :create]

  match ':page' => 'page#show'
end
