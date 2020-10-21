class Api::V1::CatchesController < Api::V1::BaseController
  before_action :check_user_authorization
  before_action :set_log, only: [ :index ]

  def index
    @catches = @log.catches.sort
  end

  private

  def set_log
    @log = @user.logs.find(params[:log_id])
  end
end
