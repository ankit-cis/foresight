require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq', constraints: AdminConstraint.new

  resources :messages do
    member do
      get :send_message
    end
  end
  
  resources :event_types
  resources :settings
  resources :statuses

  resources :periods
  resources :free_periods

  post '/tinymce_assets' => 'tinymce_assets#create'

  resources :accidents do
    collection { get :search, to: 'accidents#index' }
  end
  
  resources :videos do
    collection { get :search, to: 'videos#index' }
    
    member do
      get :subtitles
    end
  end
    
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :password_resets

  resources :users do
    collection { get :search, to: 'users#index' }
    
    resources :user_devices
    
    member do
      get :toggle_super_user
      get :revoke_license
      get :resend_welcome_email
    end
    collection do
      post :import
    end
  end
  resources :sessions

  resources :dashboard
  
  resources :companies do
    resources :users do
      collection do
        post :import
      end
    end
  end
  resources :payment_types
  resources :company_types
  resources :titles

  resources :reports

  resources :messages

  resources :settings do
    member do
      get :reset_all_passwords
    end
  end

  resources :api_users

  resources :my_profile do
    member do
      get :change_password
      post :update_password
    end
  end

  resources :dash_cam_videos

  root :to => "dashboard#index"

  get "#{Rails.root.to_s}/public/:file_path",
      to: redirect('/%{file_path}'),
      constraints: { file_path: %r{uploads/.*} }

  # MyPlayLife API
  ###################################################
  require 'api_constraints'
  
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      post 'register', to: 'users#create', as: 'register'
      post 'login', to: 'sessions#create', as: 'login'
      get 'logout', to: 'sessions#destroy', as: 'logout'

      resources :password_resets

      resources :users do
        member do
          post :password
        end
      end

      resources :messages
      
      resources :user_devices
      resources :user_events
      
      resources :videos
      resources :accidents do
        resources :vehicles
        resources :photos
        resources :witnesses
      end
      
      get 'version', to: 'website_version#index', as: 'version'

    end
  end  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
