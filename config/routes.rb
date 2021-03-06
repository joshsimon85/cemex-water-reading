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
    resources :water_meter_readings, param: :slug, except: :delete

    get '/audit_history', to: 'audits#index'
    get '/accounts', to: 'users#index'
    post '/account/:slug/deactivate', to: 'deactivations#create', as: :deactivation
    delete '/account/:slug/activate', to: 'deactivations#destroy', as: :activation
    post '/deactivate', to: 'deactivations#deactivate_own', as: :deactivate_own
  end
end
