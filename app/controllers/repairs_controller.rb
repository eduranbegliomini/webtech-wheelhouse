class RepairsController < ApplicationController
  def index
    @repairs = Repair.includes(bike: :customer).order(promised_on: :desc)
  end

  def show
    @repair = Repair.find(params[:id])
  end
end