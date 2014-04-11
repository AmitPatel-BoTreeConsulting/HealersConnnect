HealersConnnect::Application.routes.draw do
    devise_for :users

  root :to => 'static_pages#home'

  devise_scope :user do
    get "/signin" => "devise/sessions#new"
    get "/signout" => "devise/sessions#destroy"
  end

  get '/dashboard' => 'users#dashboard', as: :dashboard

  resources :centers
  resources :registrations do
    member do
      put :deactivate
      put :activate
      get :export
    end
  end
  resources :courses
  get 'static/new_center' => 'static_pages#new_center'
  get 'static/registration' => 'static_pages#registration'
  get 'static/home' => 'static_pages#home'
  get 'registration' => 'registrations#registration', as: :export
end
