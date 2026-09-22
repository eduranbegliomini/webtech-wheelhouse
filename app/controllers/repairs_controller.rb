class RepairsController < ApplicationController
  def index
    @repairs = Repair.includes(bike: :customer).newest_first
  end

  def show
    @repair = Repair.includes(:bike, repair_services: :service).find(params[:id])
  end
end