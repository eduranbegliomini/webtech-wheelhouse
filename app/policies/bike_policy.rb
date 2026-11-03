class BikePolicy < ApplicationPolicy
  def index?; user.owner? || user.counter?; end
  def show?; index?; end
  def create?; index?; end
  def update?; index?; end
  def destroy?; index?; end

  class Scope < Scope
    def resolve
      user.mechanic? ? scope.none : scope.all
    end
  end
end
