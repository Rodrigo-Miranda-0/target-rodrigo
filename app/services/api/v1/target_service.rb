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
        match
        new_target
      end

      def match
        location = "POINT(#{@longitude} #{@latitude})"
        matched_targets = Target.where(topic_id: @target_params[:topic_id]).where.not(user_id: @current_user.id).where(
          'ST_Distance(location, ?) < ?', location, @target_params[:radius]
        )

        matched_targets.each do |target|
          ApplicationMailer.target_match(target).deliver_now
          Conversation.create!(user1: @current_user, user2: target.user)
        end
      end
    end
  end
end
