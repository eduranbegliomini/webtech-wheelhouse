class ServicesController < ApplicationController
  allow_unauthenticated_access only: [:index, :show]
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  def index
    @services = policy_scope(Service).by_name
  end

  def show
    authorize @service
  end

  def new
    @service = Service.new
    authorize @service
  end

  def create
    @service = Service.new(service_params)
    authorize @service
    
    if @service.save
      redirect_to @service, notice: "Service #{@service.name} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @service
  end

  def update
    authorize @service
    if @service.update(service_params)
      redirect_to @service, notice: "Service #{@service.name} was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @service
    if @service.destroy
      redirect_to services_path, status: :see_other, notice: "Service #{@service.name} was deleted."
    else
      redirect_to @service, alert: @service.errors.full_messages.to_sentence
    end
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.expect(service: [:name, :price])
  end
end