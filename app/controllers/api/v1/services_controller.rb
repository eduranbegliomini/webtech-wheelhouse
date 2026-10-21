class Api::V1::ServicesController < Api::V1::ApiController
  before_action :authenticate_api_user!, only: [:create]

  def index
    services = Service.includes(:repair_services).by_name
    render json: services.map { |s| serialize_service(s) }, status: :ok
  end

  def show
    service = Service.includes(:repair_services).find(params[:id])
    render json: serialize_service(service), status: :ok
  end

  def create
    service = Service.new(service_params)
    if service.save
      render json: serialize_service(service), status: :created, location: api_v1_service_url(service)
    else
      render json: { errors: service.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def serialize_service(service)
    {
      id: service.id,
      name: service.name,
      price: service.price.to_s, 
      charged_count: service.repair_services.size
    }
  end

  def service_params
    params.expect(service: [:name, :price])
  end
end