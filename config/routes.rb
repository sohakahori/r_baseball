Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  #

  namespace :admin do
    resources :teams
  end

  scope module: :public do
    # 例resources :products # => /products
  end
end
