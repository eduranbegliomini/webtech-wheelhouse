class EmployeePolicy < ApplicationPolicy
  def index?; user.owner? || user.counter? || user.mechanic?; end
  def show?; index?; end
  def create?; user.owner? || user.counter?; end
  def update?; create?; end
  def destroy?; create?; end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end