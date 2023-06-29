class ClientController < ApplicationController

  # prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  tailsman_for :user

  before_action :authenticate_user

end
