class ServicePolicy < ApplicationPolicy
  def index?; true; end
  def show?; true; end
  def create?; user&.owner? || user&.counter?; end
  def update?; create?; end
  def destroy?; create?; end

  class Scope < Scope
    def resolve
      scope.all 
    end
  end
end