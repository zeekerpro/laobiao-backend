class Client::ReferralsController < ClientController

  before_action :set_referral, only: [:update]

  def index
    @referrals = current_user.referrals
    render json: @referrals, status: :ok
  end

  def create
    return if performed?
    @referral = Referral.new(referrer: current_user)
    if @referral.save
      render json: Referral.all, status: :created
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
