class ApplicationController < ActionController::Base

  # protect_from_forgery with: :null_session

  include Tailsman

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :access_denied

  private

    def access_denied
      render json: { error: 'Access denied' }, status: :forbidden
    end

end

