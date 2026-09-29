class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.by_role_and_name
  end

  def show
    @repairs = @employee.repairs.includes(bike: :customer).newest_first
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee, notice: "Staff member #{@employee.name} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee, notice: "Staff member #{@employee.name} was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @employee.destroy
      redirect_to employees_path, status: :see_other, notice: "Staff member #{@employee.name} was deleted."
    else
      redirect_to @employee, alert: @employee.errors.full_messages.to_sentence
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
    @repairs = @employee.repairs.includes(bike: :customer).newest_first
  end

  def employee_params
    params.expect(employee: [:name, :role])
  end
end