require('sidekiq/web')

Rails.application.routes.draw do
  # mount ActionCable.server => '/cable'
  mount ActionCable.server => '/cable'

  defaults format: :json do
    draw :client
  end

  draw :console

end
