Rails.application.routes.draw do

  defaults format: :json do
    draw :client
  end

  mount LaobiaoChat::Engine => "/chat"

end
