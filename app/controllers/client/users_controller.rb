class Client::UsersController < ClientController

  skip_before_action :authenticate_user, only: [ :create ]

  def create
    @user = User.new(user_params)
    referral = Referral.find_by(code: params[:user][:referral_code]) if params[:user][:referral_code]

    render json: { error: 'Invalid referral code' }, status: :unprocessable_entity and return if !referral
    render json: { error: 'Referral code has been used' }, status: :unprocessable_entity and return if referral.referred

    @user.referral = referral

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end

  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :phone,
      :username,
      :password,
      :password_confirmation
    )
  end


end
