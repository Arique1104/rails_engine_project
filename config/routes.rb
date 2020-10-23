Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/most_revenue', to: 'search#most_revenue'
        get '/find_all', to: 'search#find_all'
        get '/find', to: 'search#find'
        get ':id/items', to: 'search#show'
      end
      resources :merchants
      namespace :items do
        get '/find_all', to: 'search#find_all'
        get '/find', to: 'search#find'
        get ':id/merchant', to: 'search#show'
      end
      resources :items
    end
  end
end
