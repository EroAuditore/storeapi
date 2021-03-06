Rails.application.routes.draw do
 
  namespace :api do
    namespace :v1 do
      #Products
      get '/products', to: 'products#index'
      post '/product/new', to: 'products#create'
      put '/product/update', to: 'products#update'
      #Clients
      get '/clients', to: 'clients#index'
      post '/client/new', to: 'clients#create'
      put '/client/update', to: 'clients#update'
      #Sales
      get '/sale', to: 'sales#index'
      post '/sale/new', to: 'sales#create'
      get '/sales/day', to: 'sales#sales_today'
      get '/sales/week', to: 'sales#sales_week'
      get '/sales/month', to: 'sales#sales_month'
      #credit
      get '/credit/client/:id', to: 'credits#credit_client'
      post '/credit/client/add', to: 'credits#add_to_credit'
      get '/credit/tickets/:client_id', to: 'credits#credit_detail'
      put '/credit/close', to: 'credits#close_credit'

      
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
