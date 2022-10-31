# Class is responsible for handling the requests for the topics
module Api
  module V1
    class TopicController < ApiController
      def index
        @topics = Topic.all
      end
    end
  end
end
