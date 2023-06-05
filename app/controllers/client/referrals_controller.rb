class Client::ReferralsController < ClientController

  befeore_action :check_user, only: [:create]
  befeore_action :set_referral, only: [:update]

  def create
    return if performed?
    @referral = Referral.new(referrer: @user)
    if @referral.save
      render json: { referral: @referral }, status: :created
    else
      render json: { error: @referral.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @referral.update_attribute(:referred, current_user)
    render json: { referral: @referral }, status: :ok
  end

  private

    def check_user
      @user = User.find(params[:user_id])
      render json: { error: 'User not found' }, status: :not_found unless @user
    end

    def set_referral
      @referral = Referral.find(params[:id])
    end

end
