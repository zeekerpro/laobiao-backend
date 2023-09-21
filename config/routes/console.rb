namespace :console do
  get   'login',  to: 'sessions#new'
  post  'login',  to: 'sessions#create'
  post  'logout', to: 'sessions#destroy'

  # todo: need to login to access sidekiq, please create a login page
  # constraints lambda { |request| RouteConstraints.is_admin?(request, :user) } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end

end
