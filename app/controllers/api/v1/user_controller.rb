module Api
  module V1
    class UserController < ApiController
      def update
        if current_user.id == params[:id].to_i
          current_user.avatar.attach(params[:avatar]) if params[:avatar]
          current_user.update!(user_params)
          render json: current_user, status: :ok
        else
          render_unauthorized
        end
      end

      private

      def user_params
        params.permit(:name, :last_name, :gender, :avatar)
      end
    end
  end
end
