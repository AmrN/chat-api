Rails.application.routes.draw do

  scope '/api' do
    resources :chatrooms do
      resources :messages
    end

    get '/users/current' => 'users#current', as: 'current_user'
    resources :users

    mount Knock::Engine => "/auth"
  end

  mount ActionCable.server => '/cable'

  # otherwise serve angular app
  get '*path' => 'angular_app#index'

end
