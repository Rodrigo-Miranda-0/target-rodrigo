module Api
  module V1
    class AboutController < ApiController
      def index
        p About.first
        render json: About.first
      end
    end
  end
end
