class Api::V1::BaseController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def check_user_authorization
    unauthorized_action unless current_user == User.find(params[:user_id])
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def unauthorized_action
    render json: { error: "Action not authorized for the user: #{current_user.username}." }, status: :unauthorized
  end
end
