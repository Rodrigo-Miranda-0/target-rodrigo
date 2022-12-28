module Api
  module V1
    class ApiController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      include ActiveStorage::SetCurrent
      include Pundit::Authorization

      before_action :authenticate_user!
      before_action :configure_permitted_parameters, if: :devise_controller?

      rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid,         with: :render_record_invalid
      rescue_from ActionController::ParameterMissing,  with: :render_parameter_missing
      rescue_from Pundit::NotAuthorizedError,          with: :render_unauthorized

      protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :gender])
      end

      private

      def render_not_found(exception)
        logger.info { exception } # for logging
        render json: { error: I18n.t('api.errors.not_found') }, status: :not_found
      end

      def render_record_invalid(exception)
        logger.info { exception } # for logging
        render json: { errors: exception.record.errors.as_json }, status: :bad_request
      end

      def render_parameter_missing(exception)
        logger.info { exception } # for logging
        render json: { error: I18n.t('api.errors.missing_param') }, status: :unprocessable_entity
      end

      def render_unauthorized
        render json: { error: I18n.t('api.errors.unauthorized') }, status: :unauthorized
      end
    end
  end
end
