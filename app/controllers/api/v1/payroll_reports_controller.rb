class Api::V1::PayrollReportsController <  ActionController::API
  def create
    result = PayrollReports::GenerateService.new(params[:month], params[:year]).generate
    render json: result
  end
end
