class Client::ReferralPolicy

  attr_reader :user, :referral

  def initialize(user, referral)
    @user = user
    @referral = referral
  end

  def index?
    true
  end

  def create
    true
  end

  def update
    true
  end

end
