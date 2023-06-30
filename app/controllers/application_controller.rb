class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  before_action :snakify_params

  include Tailsman

  include Pundit::Authorization

  # support :json, :xml, :jsonapi
  include Graphiti::Rails::Responders

  rescue_from Pundit::NotAuthorizedError, with: :access_denied

  private

    def access_denied
      render json: { error: 'Access denied' }, status: :forbidden
    end

    def snakify_params
      params.deep_transform_keys! &:underscore
    end

end

