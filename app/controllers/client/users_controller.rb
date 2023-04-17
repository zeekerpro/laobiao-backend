class Client::UsersController < ClientController

  skip_before_action :authenticate_user, only: [ :create ]

  def create

    @user = User.new(user_params)

    @user.save ?
      (render json: @user, status: :created) :
      (render json: @user.errors, status: :unprocessable_entity)

  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :phone,
      :username,
      :password,
      :password_confirmation,
    )
  end


end
