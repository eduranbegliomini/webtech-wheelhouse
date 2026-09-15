class EmployeesController < ApplicationController
  def index
    @employees = Employee.order(:role, :name)
  end

  def show
    @employee = Employee.find(params[:id])
  end
end