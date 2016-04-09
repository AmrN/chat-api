Rails.application.routes.draw do

  scope '/api' do
    resources :chatrooms do
      resources :messages
      # member do
      #   post 'subscribe'
      # end
      resource :subscriptions, except: [:show, :update] do
        get '', on: :collection, action: :index
      end
    end

    get '/users/current' => 'users#current', as: 'current_user'
    resources :users do
      resource :friendships, only: [:create, :destroy]

      member do
        get "acquaintanceship"
        get "friends"
      end
    end

    mount Knock::Engine => "/auth"
  end

  mount ActionCable.server => '/cable'

  # otherwise serve angular app
  get '*path' => 'angular_app#index'

end
