module Api
  module V1
    class TargetsController < ApiController
      def index
        @targets = current_user.targets
      end

      def create
        @target = TargetService.new(target_params, current_user, params[:latitude], params[:longitude]).create
        render status: :created, json: @target
      end

      private

      def target_params
        params.require(:target).permit(:title, :radius, :topic_id)
      end
    end
  end
end
