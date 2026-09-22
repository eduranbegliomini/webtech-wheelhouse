class BikesController < ApplicationController
  def index
    @bikes = Bike.includes(:customer).by_make_and_model
  end

  def show
    @bike = Bike.find(params[:id])
    @repairs = @bike.repairs.includes(bike: :customer).newest_first
  end
end