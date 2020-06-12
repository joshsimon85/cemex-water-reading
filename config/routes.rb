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
    scope '/admin' do
      resources :water_meter_readings, param: :slug, except: [:new, :create]

      get '/accounts', to: 'deactivations#index'
    end

    #get '/water_meter_reading/new', to: 'water_meter_readings#new'
    resources :water_meter_readings, param: :slug, only: [:new, :create]
  end
end
