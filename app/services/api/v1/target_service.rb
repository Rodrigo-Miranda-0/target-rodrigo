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
        raise MaxTargetError if @current_user.targets.count >= Target::MAX_TARGETS

        location = "POINT(#{@longitude} #{@latitude})"
        new_target = @current_user.targets.create!(@target_params.merge(location:))
        find_matches(new_target)
        new_target
      end

      def find_matches(new_target)
        matched_targets = Target.by_topic(new_target.topic).not_by_user(@current_user.id).within_radius(new_target)

        matched_targets.each do |target|
          ApplicationMailer.target_match(target).deliver_now
          Conversation.create!(user1: @current_user, user2: target.user)
        end
      end
    end
  end
end
