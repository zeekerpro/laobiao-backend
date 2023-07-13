class Client::UsersController < ClientController

  skip_before_action :authenticate_user, only: [ :create ]

  def index
    respond_with(UserResource.all(params))
  end

  def show
    user = UserResource.find(params)
    respond_with(user)
  end

  def create
    debugger
    user = UserResource.build(params)

    # referral = Referral.find_by(code: params[:user][:referral_code]) if params[:user][:referral_code]

    # render json: { error: 'Invalid referral code' }, status: :unprocessable_entity and return if !referral
    # render json: { error: 'Referral code has been used' }, status: :unprocessable_entity and return if referral.referred
    #
    # user.referral = referral

    if user.save
      render jsonapi: user, status: :created
    else
      render jsonapi_errors: user
    end
  end

  def update
    user = UserResource.find(params)

    if user.update_attributes
      render jsonapi: user
    else
      render jsonapi_errors: user
    end
  end

  def destroy
    user = UserResource.find(params)

    if user.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: user
    end
  end

end
