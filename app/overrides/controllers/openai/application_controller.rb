Openai::ApplicationController.class_eval do

  include Tailsman

  tailsman_for :user

  before_action :authenticate_user

end
