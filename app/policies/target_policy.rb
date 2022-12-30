class TargetPolicy < ApplicationPolicy
  def destroy?
    admin? || belongs_to_user?
  end
end
