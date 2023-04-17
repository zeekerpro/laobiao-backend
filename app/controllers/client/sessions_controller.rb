class Client::SessionsController < ClientController

  skip_before_action :authenticate_user, only: [:create]

  def create
  end

  def destroy
  end

end
