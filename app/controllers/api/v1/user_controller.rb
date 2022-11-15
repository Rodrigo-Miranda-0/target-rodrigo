module Api
  module V1
    class UserController < ApiController
      def update
        current_user.update(user_params)
        render json: current_user, status: :ok
      end

      private

      def user_params
        params.permit(:name, :lastname, :gender)
      end
    end
  end
end
