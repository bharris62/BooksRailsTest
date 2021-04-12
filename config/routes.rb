Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :books, only: %i[index create destroy]
      resources :test
      post 'authenticate', to: 'authentication#create'
    end
  end
end
