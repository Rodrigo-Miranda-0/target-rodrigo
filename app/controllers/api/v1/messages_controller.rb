module Api
  module V1
    class MessagesController < Api::V1::ApiController
      def create
        conversation = Conversation.find(conversation_params[:conversation_id])
        authorize conversation, policy_class: MessagePolicy
        message = MessageService.new(message_params, current_user, conversation).create
        render json: message, status: :created
      rescue UnauthorizedConversationError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      def index
        conversation = Conversation.find(params[:conversation_id])
        authorize conversation, policy_class: MessagePolicy

        @messages = conversation.messages.page(params[:page])
      rescue UnauthorizedConversationError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      private

      def message_params
        params.require(:message).permit(:content)
      end

      def conversation_params
        params.permit(:conversation_id)
      end
    end
  end
end
