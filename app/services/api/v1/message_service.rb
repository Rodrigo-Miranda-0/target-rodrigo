module Api
  module V1
    class MessageService
      def initialize(message_params, current_user, conversation)
        @message_params = message_params
        @current_user = current_user
        @conversation = conversation
      end

      def create
        @message = Message.create!(content: @message_params[:content], user: @current_user, conversation_id: @conversation.id)
        notify(@conversation) if @message.persisted?
        @message
      end

      private

      def notify(conversation)
        recipient_user = conversation.recipient_user(@current_user)
        ApplicationMailer.new_message(recipient_user, @message).deliver_now
      end
    end
  end
end
