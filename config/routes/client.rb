
scope module: :client do

  root 'welcome#index'

  get 'me', to: 'sessions#me'

  post 'signin', to: 'sessions#create'

  post 'signup', to: 'users#create'

  resources :referrals, only: [ :index, :create, :update ]

  resources :chats do
    post 'stream', on: :collection
  end

end
