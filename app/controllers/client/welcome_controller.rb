class Client::WelcomeController < ClientController

  skip_before_action :authenticate_user

  def index
    render json: { message: 'Welcome to the laobiao API' }
  end

end
