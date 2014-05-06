HealersConnnect::Application.routes.draw do
  devise_for :users

  root :to => 'static_pages#home'

  devise_scope :user do
    get '/signin' => 'devise/sessions#new'
    get '/signout' => 'devise/sessions#destroy'
  end

  get '/dashboard' => 'users#dashboard', as: :dashboard
  post '/search' => 'donations#index', as: :search_donations

  resources :instructors
  resources :centers
  resources :courses do
    member do
      put :deactivate
      put :activate
    end
  end

  # resources :registrations, only: [:index]
  resources :workshops do
    resources :registrations do
      member do
        put :deactivate
        put :activate
        get :export
      end
    end
  end
  post 'workshops/course/instructors' => 'workshops#course_instructors'
  post 'workshop_sessions/destroy' => 'workshops#destroy_workshop_session'
  resources :donations
  post 'check_phone_number' => 'users#check_phone_number'
  get 'static/new_center' => 'static_pages#new_center'
  get 'static/registration' => 'static_pages#registration'
  get 'static/home' => 'static_pages#home'
  get 'export_registrations' => 'registrations#export_registrations', as: :export_registrations
  get 'donation/:id' => 'donations#export', as: :export_donation_pdf

  post 'event_schedule/upload_photo' => 'event_schedules#upload_photo', as: :upload_photo
  delete 'event_schedules/:id' => 'event_schedules#remove_event_photo', as: :remove_event_photo

  resources :events
  resources :event_schedules
end
