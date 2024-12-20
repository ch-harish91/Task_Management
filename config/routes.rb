Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  put 'assign_user', to: 'v1/projects#assign_user'
  get 'project_users', to: 'v1/projects#project_users'

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :v1 do
    resources :users do
      resource :profile
    end
    resources :organizations do
      resources :projects
    end
  end
end
