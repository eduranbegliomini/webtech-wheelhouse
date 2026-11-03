class BikesController < ApplicationController
  before_action :set_bike, only: [:show, :edit, :update, :destroy]

  def index
    authorize Bike
    @bikes = policy_scope(Bike)
  end

  def show
    authorize @bike
  end

  def new
    @bike = Bike.new
    authorize @bike
  end

  def create
    @bike = Bike.new(bike_params)
    authorize @bike
    if @bike.save
      redirect_to @bike, notice: "Bike was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @bike
  end

  def update
    authorize @bike
    if @bike.update(bike_params)
      redirect_to @bike, notice: "Bike was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @bike
    if @bike.destroy
      redirect_to bikes_path, status: :see_other, notice: "Bike was successfully deleted."
    else
      redirect_to @bike, alert: @bike.errors.full_messages.to_sentence
    end
  end

  private

  def set_bike
    @bike = Bike.find(params[:id])
  end

  def bike_params
    params.expect(bike: [:customer_id, :make, :model, :color, :serial_number])
  end
end