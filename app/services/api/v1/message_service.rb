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

        @message = Message.create!(content: @message_params[:content], user: @current_user, conversation_id: @conversation_id)
        notify
        @message
      end

      def notify
        conversation = Conversation.find(@conversation_id)
        user1 = User.find(conversation.user1_id)
        user2 = User.find(conversation.user2_id)
        if @current_user.id == user1.id
          ApplicationMailer.new_message(user2, @message).deliver_now
        else
          ApplicationMailer.new_message(user1, @message).deliver_now
        end
      end
    end
  end
end
