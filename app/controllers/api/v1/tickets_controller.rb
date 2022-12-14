module Api
  module V1
    class TicketsController < ApiController
      def create
        # Checks if the email is registered to an admin user
        return render json: { error: I18n.t('api.v1.tickets.error') }, status: :bad_request if AdminUser.find_by(email: params[:email]).blank?

        ApplicationMailer.ticket_email(current_user, ticket_params).deliver_now
        render json: { message: I18n.t('api.v1.tickets.success') }, status: :created
      end

      private

      def ticket_params
        params.require(:ticket).permit(:email, :message)
      end
    end
  end
end
