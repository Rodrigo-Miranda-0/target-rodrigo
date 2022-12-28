class MessagePolicy < ApplicationPolicy
  def create?
    user_belongs_to_conversation?
  end

  def index?
    user_belongs_to_conversation?
  end

  private

  def user_belongs_to_conversation?
    record.user1_id == user.id || record.user2_id == user.id
  end
end
