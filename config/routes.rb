Rails.application.routes.draw do

  apipie

  root to: "public/teams#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  #
  # devise_for :admins, path: 'admin/admins'
  devise_for :admins, :controllers => {
      sessions: "admin/admins/sessions",
      registrations: "admin/admins/registrationsregistrationsregistrations",
      passwords: "admin/admins/passwords"
  }

  devise_for :users, controllers: {
      sessions: 'public/users/sessions',
      registrations: 'public/users/registrations',
      passwords: "public/users/passwords"
  }

  namespace :admin do
    resources :teams, except: :show do
      resources :players
    end

    resources :current_passwords, only: [:new, :create]
    resources :admins
  end


  # API
  namespace :api do
    namespace :v1 do
      resources :teams
    end
  end


  # scope module: :public do
  #   # 例resources :products # => /products
  # end
end
