require('sidekiq/web')

Rails.application.routes.draw do

  # todo: need to login to access sidekiq, please create a login page
  constraints lambda { |request| RouteConstraints.is_admin?(request, :user) } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # mount ActionCable.server => '/cable'
  mount ActionCable.server => '/cable'

  defaults format: :json do
    draw :client
  end

end
