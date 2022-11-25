module Api
  module V1
    class MessagesController < ApiController
      def create
        message = MessageService.new(message_params, current_user, params[:conversation_id]).create
        render json: message, status: :created
      rescue InvalidConversationError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      private

      def message_params
        params.require(:message).permit(:content)
      end
    end
  end
end
