class Client::ReferralsController < ClientController
  def index
    referrals = ReferralResource.all(params)
    respond_with(referrals)
  end

  def show
    referral = ReferralResource.find(params)
    respond_with(referral)
  end

  def create
    referral = ReferralResource.build(params)

    if referral.save
      render jsonapi: referral, status: 201
    else
      render jsonapi_errors: referral
    end
  end

  def update
    referral = ReferralResource.find(params)

    if referral.update_attributes
      render jsonapi: referral
    else
      render jsonapi_errors: referral
    end
  end

  def destroy
    referral = ReferralResource.find(params)

    if referral.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: referral
    end
  end
end
