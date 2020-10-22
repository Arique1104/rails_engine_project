Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :api do
    namespace :v1 do
      resources :merchants
      namespace :merchants do
        get ':id/items', to: 'search#show'
      end
      resources :items
      namespace :items do
        get ':id/merchant', to: 'search#show'
      end

    end
  end
end
