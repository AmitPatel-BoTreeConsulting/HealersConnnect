HealersConnnect::Application.routes.draw do
  devise_for :users

  root :to => 'users#index'
  devise_scope :user do
    get "/signin" => "devise/sessions#new"
    get "/signout" => "devise/sessions#destroy"
  end

  get '/dashboard' => 'users#dashboard', as: :dashboard
end