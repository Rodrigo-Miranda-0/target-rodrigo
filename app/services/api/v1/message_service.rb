module Api
  module V1
    class MessageService
      def initialize(message_params, current_user, conversation_id)
        @message_params = message_params
        @current_user = current_user
        @conversation_id = conversation_id
      end

      def create
        conversation = Conversation.find(@conversation_id)
        raise InvalidConversationError unless conversation.user1_id == @current_user.id || conversation.user2_id == @current_user.id

        Message.create!(content: @message_params[:content], user: @current_user, conversation_id: @conversation_id)
      end
    end
  end
end
