Rails.application.routes.draw do
 
  namespace :api do
    namespace :v1 do
      get '/products', to: 'products#index'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # get 'private/test'
  # get '/current_user', to: 'current_user#index'
  # get '/member-data', to: 'members#show'
end
