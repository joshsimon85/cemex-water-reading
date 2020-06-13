Rails.application.routes.draw do
  devise_for :users, path: '', controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  devise_scope :user do
    root to: 'users/sessions#new'
  end

  authenticated do
    resources :invitations, only: [:index, :create, :destroy]
    resources :water_meter_readings, param: :slug

    get '/accounts', to: 'users#index'
    post '/account/:slug/deactivate', to: 'deactivations#create', as: :deactivation
    delete '/account/:slug/activate', to: 'deactivations#destroy', as: :activation
  end
end
