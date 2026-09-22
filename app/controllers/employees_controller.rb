class EmployeesController < ApplicationController
  def index
    @employees = Employee.by_role_and_name
  end

  def show
    @employee = Employee.find(params[:id])
    @repairs = @employee.repairs.includes(bike: :customer).newest_first
  end
end