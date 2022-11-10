module Api
  module V1
    class TargetsController < ApiController
      def create
        @target = TargetService.new(target_params, current_user, params[:latitude], params[:longitude]).create
        render json: @target, status: :created
      rescue MaxTargetError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      private

      def target_params
        params.require(:target).permit(:title, :radius, :topic_id)
      end
    end
  end
end
