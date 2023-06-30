scope module: :client, defaults: {format: :jsonapi} do

  root 'welcome#index'

  get 'me', to: 'sessions#me'

  post 'signin', to: 'sessions#create'

  post 'signup', to: 'users#create'

  resources :referrals
  resources :users

  mount Openai::Engine => "/openai"

end
