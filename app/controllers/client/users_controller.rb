class Client::UsersController < ClientController

  skip_before_action :authenticate_user, only: [ :create ]

  def create
    @user = User.new(user_params)
    render json: { error: 'Invalid referral code' }, status: :unprocessable_entity and return if params[:referral_code] && !User.find_by(referral_code: params[:referral_code])

    user.referrer = User.find_by(referral_code: params[:referral_code])
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
