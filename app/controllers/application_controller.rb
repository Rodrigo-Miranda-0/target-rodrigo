class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers

  respond_to :json, :html
end
