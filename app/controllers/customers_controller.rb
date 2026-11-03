class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    authorize Customer 
    @customers = policy_scope(Customer)
  end

  def show
    authorize @customer
  end

  def new
    @customer = Customer.new
    authorize @customer
  end

  def create
    @customer = Customer.new(customer_params)
    authorize @customer
    if @customer.save
      redirect_to @customer, notice: "Customer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @customer
  end

  def update
    authorize @customer
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Customer was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @customer
    if @customer.destroy
      redirect_to customers_path, status: :see_other, notice: "Customer was successfully deleted."
    else
      redirect_to @customer, alert: @customer.errors.full_messages.to_sentence
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.expect(customer: [:name, :email, :phone])
  end
end