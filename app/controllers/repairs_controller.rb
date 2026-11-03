class RepairsController < ApplicationController
  before_action :set_repair, only: [:show, :edit, :update, :destroy]

  def index
    @repairs = policy_scope(Repair).includes(:bike, :taken_in_by, repair_services: :service).newest_first
  end

  def show
    authorize @repair
  end

  def new
    @repair = Repair.new
    authorize @repair
  end

  def create
    @repair = Repair.new(repair_params)
    @repair.taken_in_by = Current.user
    authorize @repair

    if @repair.save
      redirect_to @repair, notice: "Repair was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @repair
  end

  def update
    authorize @repair
    if @repair.update(repair_params)
      redirect_to @repair, notice: "Repair was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @repair
    @repair.destroy
    redirect_to repairs_url, notice: "Repair was successfully destroyed."
  end

  private

  def set_repair
    @repair = Repair.find(params[:id])
  end

  def repair_params
    params.require(:repair).permit(policy(@repair || Repair).permitted_attributes)
  end
end