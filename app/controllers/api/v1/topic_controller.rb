module Api
  module V1
    class TopicController < ApiController
      def index
        @topics = Topic.includes(:image_attachment).all
      end
    end
  end
end
