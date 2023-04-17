
scope module: :client do

  post 'signin', to: 'sessions#create'

  post 'signup', to: 'users#create'

end
