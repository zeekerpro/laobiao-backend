Rails.application.routes.draw do

  defaults format: :json do
    draw :client
  end

end
