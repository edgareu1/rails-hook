class Api::V1::BaseController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def check_user
    @user = User.find(params[:user_id])

    return request.headers["X-User-Email"] == @user.email &&
           request.headers["X-User-Token"] == @user.authentication_token
  end

  def check_user_authorization
    unauthorized_action unless check_user
  end

  def unauthorized_action
    render json: { error: "Action only authorized for the user: #{@user.username}." }, status: :unauthorized
  end
end
