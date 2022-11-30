module Api
  module V1
    class MessagesController < ApiController
      def create
        message = MessageService.new(message_params, current_user, conversation_params).create
        render json: message, status: :created
      rescue UnauthorizedConversationError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      def index
        conversation = Conversation.find(params[:conversation_id])
        raise InvalidConversationError unless conversation.user1_id == @current_user.id || conversation.user2_id == @current_user.id

        render json: { messages: conversation.messages.page(params[:page]) }, status: :ok
      rescue InvalidConversationError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      private

      def message_params
        params.permit(:content)
      end

      def conversation_params
        params.permit(:conversation_id)
      end
    end
  end
end
