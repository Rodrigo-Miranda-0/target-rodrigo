module Api
  module V1
    class TargetService
      def initialize(target_params, current_user, longitude, latitude)
        @target_params = target_params
        @current_user = current_user
        @longitude = longitude
        @latitude = latitude
      end

      def create
        # byebug
        location = ActiveRecord::Point.new(@longitude, @latitude)
        @current_user.targets.create!(@target_params.merge(location:))
      end
    end
  end
end
