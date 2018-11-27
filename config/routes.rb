Rails.application.routes.draw do

  apipie

  root to: "public/teams#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  #
  # devise_for :admins, path: 'admin/admins'
  devise_for :admins, :controllers => {
      sessions: "admin/admins/sessions",
      registrations: "admin/admins/registrations",
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
  #
  # /api/v1/authでアクセス可能
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/auth/registrations'
      }
    end
  end

  namespace :api do
    namespace :v1 do
      resources :teams do
        resources :players, only: [:index, :show]
      end

      resources :boards, only: [:index, :create, :destroy] do
        resources :responses, only: [:index, :create, :destroy]
      end
    end
  end


  # scope module: :public do
  #   # 例resources :products # => /products
  # end
end



