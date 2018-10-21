Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  #
  # devise_for :admins, path: 'admin/admins'
  devise_for :admins, :controllers => {
      sessions: "admin/admins/sessions",
      registrations: "admin/admins/registrations",
      passwords: "admin/admins/passwords"
  }

  namespace :admin do
    resources :teams, except: :show do
      resources :players
    end

    resources :current_passwords, only: [:new, :create]
  end

  scope module: :public do
    # 例resources :products # => /products
  end
end
