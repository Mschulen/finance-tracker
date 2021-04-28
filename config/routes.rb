Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do #bullshit that makes devise work
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  root "welcome#index"
end
