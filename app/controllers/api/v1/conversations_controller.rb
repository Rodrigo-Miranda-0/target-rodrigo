module Api
  module V1
    class ConversationsController < ApiController
      def index
        @conversations = Conversation.where(user1_id: current_user.id).or(Conversation.where(user2_id: current_user.id))
        render json: @conversations
      end
    end
  end
end
