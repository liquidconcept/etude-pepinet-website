EtudePepinet::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  match ':page' => 'page#show'
  root to: 'page#show'
end
