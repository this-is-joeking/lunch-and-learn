Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :recipes, only: :index
      resource :learning_resources, only: :show
      resources :users, only: :create
      resources :favorites, only: [:create, :index]
    end
  end
end
