Openai::ApplicationController.class_eval do

  tailsman_for :user

  before_action :authenticate_user

end
