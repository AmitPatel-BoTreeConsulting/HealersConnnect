HealersConnnect::Application.routes.draw do
  devise_for :users

  root :to => 'users#index'
  devise_scope :user do
    get "/signin" => "devise/sessions#new"
    get "/signout" => "devise/sessions#destroy"
  end

  get '/dashboard' => 'users#dashboard', as: :dashboard

  resources :centers

  get 'static/new_center' => 'static_pages#new_center'
  get 'static/registration' => 'static_pages#registration'
end
