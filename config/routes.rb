Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  devise_scope :user do #bullshit that makes devise work
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  root "welcome#index"
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
end
