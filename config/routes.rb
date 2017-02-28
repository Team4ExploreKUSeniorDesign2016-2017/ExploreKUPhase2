require 'api_constraints'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Api definition
  # namespace :api, defaults: { format: :json },
  #                             constraints: { subdomain: 'api' }, path: '/'  do
  #   scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
  #     resources :locations, :only => [:show]
  #   end
  # end

  namespace :api, defaults: { format: :json } do
    namespace :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :locations, :only => [:show, :index]
    end
  end
end
