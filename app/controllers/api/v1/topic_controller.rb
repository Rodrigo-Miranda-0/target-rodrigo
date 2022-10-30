# Class is responsible for handling the requests for the topics
module Api
  module V1
    class TopicController < ApplicationController
      before_action :authenticate_user!
      include ActiveStorage::SetCurrent
      def index
        @topics = Topic.all
      end
    end
  end
end
