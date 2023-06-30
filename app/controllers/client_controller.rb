class ClientController < ApplicationController

  tailsman_for :user

  before_action :authenticate_user

end
