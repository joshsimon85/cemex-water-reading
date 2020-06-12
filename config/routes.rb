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
      resources :water_meter_readings, param: :slug
    end
  end
end
