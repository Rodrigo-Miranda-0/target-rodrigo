module Api
  module V1
    class TicketsController < ApiController
      def create
        return render json: { error: I18n.t('api.v1.tickets.error') }, status: :bad_request unless admin_exists?

        ApplicationMailer.ticket_email(current_user, ticket_params).deliver_now
        render json: { message: I18n.t('api.v1.tickets.success') }, status: :created
      end

      private

      def ticket_params
        params.require(:ticket).permit(:email, :message)
      end

      def admin_exists?
        AdminUser.find_by(email: params[:email]).present?
      end
    end
  end
end
