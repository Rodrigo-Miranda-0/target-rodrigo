module Api
  module V1
    class AboutController < ApiController
      skip_before_action :authenticate_user!, only: [:index]

      def index
        render json: About.last
      end
    end
  end
end
