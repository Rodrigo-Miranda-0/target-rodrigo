module Api
  module V1
    class ApiController < ApplicationController
      include ActiveStorage::SetCurrent
      before_action :authenticate_user!
    end
  end
end
