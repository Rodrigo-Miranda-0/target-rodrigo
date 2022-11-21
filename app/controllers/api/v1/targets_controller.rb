module Api
  module V1
    class TargetsController < ApiController
      def index
        @targets = current_user.targets
      end

      def create
        @target = TargetService.new(target_params, current_user, params[:latitude], params[:longitude]).create
        render json: @target, status: :created
      rescue MaxTargetError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      def destroy
        @target = current_user.targets.find(params[:id])
        @target.destroy!
        head :no_content
      end

      private

      def target_params
        params.require(:target).permit(:title, :radius, :topic_id)
      end
    end
  end
end
