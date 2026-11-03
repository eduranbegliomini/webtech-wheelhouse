class RepairPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.owner? || user.counter? || (user.mechanic? && record.employee_id == user.employee_id)
  end

  def create?
    user.owner? || user.counter?
  end

  def update?
    return false if user.mechanic? && record.employee_id != user.employee_id
    
    handed_back = (record.state == "Picked Up") 
    
    if handed_back
      user.owner?
    else
      user.owner? || user.counter? || user.mechanic?
    end
  end

  def destroy?
    user.owner?
  end

  def permitted_attributes
    if user.owner? || user.counter?
      [:bike_id, :employee_id, :state, :promised_on, :customer_answer, :diagnosis, repair_services_attributes: [:id, :service_id, :charged_price, :_destroy]] # Añade tus campos extra de la reparación
    elsif user.mechanic?
      [:state, :diagnosis] 
    else
      []
    end
  end

  class Scope < Scope
    def resolve
      if user.owner? || user.counter?
        scope.all
      elsif user.mechanic?
        user.employee_id ? scope.where(employee_id: user.employee_id) : scope.none
      else
        scope.none
      end
    end
  end
end