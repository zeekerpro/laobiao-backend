class Client::SessionsController < ClientController

  skip_before_action :authenticate_user, only: [:create]

  def me
    render json: current_user, except: [:password_digest, :wechat_open_id], status: :ok
  end

  def create
    sign_in(signin_params, :account)
    return if performed?
    render json: current_user, status: :ok
  end

  private

    def signin_params
      params.require(:user).permit(
        :account,
        :email,
        :phone,
        :username,
        :password
      )
    end

end
