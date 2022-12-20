module Api
  module V1
    class MessageIndexService
      def index(conversation_id, current_user, page)
        conversation = Conversation.find(conversation_id)
        raise InvalidConversationError unless conversation.user1_id == current_user.id || conversation.user2_id == current_user.id

        messages = conversation.messages.page(page)
        read_messages(messages, current_user)
        messages
      end

      private

      def read_messages(messages, current_user)
        messages.each { |message| message.update(read: true) unless message.user == current_user }
      end
    end
  end
end
