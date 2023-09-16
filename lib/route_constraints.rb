class RouteConstraints

  class << self
    def is_admin?(request, auth_model = :user)
      token_info = request.env[:tailsman_token_info]
      current_id = token_info[:id]
      return false if current_id.blank?
      model_constant = auth_model.to_s.capitalize.constantize
      current_model_instance = model_constant.find_by(id: current_id)
      return false if current_model_instance.blank? or !current_model_instance.is_admin?
      true
    end
  end

end
