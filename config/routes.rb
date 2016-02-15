Rails.application.routes.draw do

  scope '/api' do
    resources :messages
    get '/users/current' => 'users#current', as: 'current_user'
    resources :users

    mount Knock::Engine => "/auth"
  end

  mount ActionCable.server => '/cable'

  # otherwise serve angular app
  get '*path' => 'angular_app#index'

end
