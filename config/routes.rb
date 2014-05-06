HealersConnnect::Application.routes.draw do
  devise_for :users

  root :to => 'static_pages#home'

  devise_scope :user do
    get '/signin' => 'devise/sessions#new'
    get '/signout' => 'devise/sessions#destroy'
  end

  scope '/admin' do
    resources :instructors
    resources :centers
    resources :donations
    resources :event_schedules
    resources :events
  end

  scope '/admin' do
    resources :courses do
      member do
        put :deactivate
        put :activate
      end
    end
  end

  # resources :registrations, only: [:index]
  scope '/admin' do
    resources :workshops do
      resources :registrations do
        member do
          put :deactivate
          put :activate
          get :export
        end
      end
    end
  end
  post '/admin/donations/search' => 'donations#index', as: :search_donations
  post 'workshops/course/instructors' => 'workshops#course_instructors'
  post 'workshop_sessions/destroy' => 'workshops#destroy_workshop_session'
  post 'check_phone_number' => 'users#check_phone_number'
  get 'admin/registrations/registration' => 'registrations#registration', as: :export
  get 'admin/donation/:id' => 'donations#export', as: :export_donation_pdf
  post 'admin/event_schedules/upload_photo' => 'event_schedules#upload_photo', as: :upload_photo
  delete 'admin/event_schedules/event_schedules/:id' => 'event_schedules#remove_event_photo', as: :remove_event_photo

end
