EtudePepinet::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :news, path: '/actualites'

  match ':page' => 'page#show'
  root to: 'page#show'
end
