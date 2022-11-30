Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/api/v1/auth'

  namespace :api do
    namespace :v1 do
      resources :topic, only: :index
      resources :targets, only: %i[index create destroy]
      resources :user, only: :update
      resources :conversations, only: :index
      resources :messages, only: %i[index create]
    end
  end
end
