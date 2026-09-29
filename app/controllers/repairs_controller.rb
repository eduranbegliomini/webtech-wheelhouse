class RepairsController < ApplicationController
  before_action :set_repair, only: [:show, :edit, :update, :destroy]

  def index
    @repairs = Repair.includes(bike: :customer).newest_first
  end

  def show
  end

  def new
    @repair = Repair.new(bike_id: params[:bike_id])
    3.times { @repair.repair_services.build }
  end

  def create
    @repair = Repair.new(repair_params)
    if @repair.save
      redirect_to @repair, notice: "Repair ##{@repair.id} was successfully created."
    else
      3.times { @repair.repair_services.build }
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    3.times { @repair.repair_services.build }
  end

  def update
    if @repair.update(repair_params)
      redirect_to @repair, notice: "Repair ##{@repair.id} was successfully updated."
    else
      3.times { @repair.repair_services.build }
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @repair.destroy
      redirect_to repairs_path, status: :see_other, notice: "Repair ##{@repair.id} was deleted."
    else
      redirect_to @repair, alert: @repair.errors.full_messages.to_sentence
    end
  end

  private

  def set_repair
    @repair = Repair.includes(:bike, repair_services: :service).find(params[:id])
  end

  def repair_params
    params.expect(repair: [:bike_id, :employee_id, :state, :promised_on, :handed_back_at, :customer_answer, repair_services_attributes: [:id, :service_id, :charged_price, :_destroy]])
  end
end