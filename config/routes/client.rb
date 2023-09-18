
scope module: :client do

  root 'welcome#index'

  get 'me', to: 'sessions#me'

  post 'signin', to: 'sessions#create'

  post 'signup', to: 'users#create'

  resources :referrals, only: [ :index, :create, :update ]

  resources :streams, only: [:create]

  resources :chats do
    resources :messages, on: :member do
      post 'sync_detect', on: :collection
      post 'bulk_create', on: :collection
    end
    post 'sync_detect', on: :collection
    post 'bulk_create', on: :collection
  end

  resources :api_keys


end
