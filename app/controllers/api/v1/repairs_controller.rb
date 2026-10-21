class Api::V1::RepairsController < Api::V1::ApiController
  before_action :authenticate_api_user!

  def index
    repairs = Repair.includes(bike: :customer, repair_services: :service).newest_first

    if params[:state].present?
      if Repair.states.keys.include?(params[:state])
        repairs = repairs.where(state: params[:state])
      else
        return render json: { errors: ["Invalid state. Valid states are: #{Repair.states.keys.join(', ')}"] }, status: :bad_request
      end
    end

    render json: repairs.map { |r| serialize_repair(r) }, status: :ok
  end

  def show
    repair = Repair.includes(bike: :customer, repair_services: :service).find(params[:id])
    render json: serialize_repair(repair), status: :ok
  end

  private

  def serialize_repair(repair)
    {
      id: repair.id,
      state: repair.state,
      arrived_on: repair.created_at.to_date.to_s,
      promised_on: repair.promised_on&.to_s,
      handed_back_at: repair.handed_back_at&.to_s,
      overdue: repair.overdue?,
      customer_answer: repair.customer_answer,
      total: repair.total.to_s,
      bike: {
        brand: repair.bike.make,
        model: repair.bike.model,
        serial_number: repair.bike.serial_number
      },
      customer: {
        name: repair.bike.customer.name
      },
      lines: repair.repair_services.map do |line|
        {
          service_name: line.service.name,
          charged_price: line.charged_price.to_s
        }
      end
    }
  end
end