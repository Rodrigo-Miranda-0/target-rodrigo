module Api
  module V1
    class MessagesController < Api::V1::ApiController
      def create
        message = MessageService.new(message_params, current_user, conversation_params).create
        render json: message, status: :created
      rescue UnauthorizedConversationError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      def index
        conversation = Conversation.find(params[:conversation_id])
        raise UnauthorizedConversationError unless user_belongs_to_conversation?(conversation)

        @messages = conversation.messages.page(params[:page])
      rescue UnauthorizedConversationError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      private

      def message_params
        params.permit(:content)
      end

      def user_belongs_to_conversation?(conversation)
        conversation.user1_id == @current_user.id || conversation.user2_id == @current_user.id
      end

      def conversation_params
        params.permit(:conversation_id)
      end
    end
  end
end
