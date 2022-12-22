module Api
  module V1
    class AboutController < ApiController
      def index
        render json: About.first
      end
    end
  end
end
