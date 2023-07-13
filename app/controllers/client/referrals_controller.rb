class Client::ReferralsController < ClientController

  before_action :set_referral, only: [:update]

  def index
    authorize :referral, :index?, policy_class: Client::ReferralPolicy
    @referrals = current_user.referrals
    render json: @referrals, include: [:referred], status: :ok
  end

  def create
    return if performed?
    @referral = Referral.new(referrer: current_user)
    if @referral.save
      render json: @referral, include: [:referred], status: :created
    else
      render json: { error: @referral.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @referral.update_attribute(:referred, current_user)
    render json: { referral: @referral }, status: :ok
  end

  private

    def set_referral
      @referral = Referral.find(params[:id])
    end

end
