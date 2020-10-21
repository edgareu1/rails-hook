class Api::V1::CatchesController < Api::V1::BaseController
  before_action :check_user_authorization
  before_action :set_log, only: [ :index, :create, :destroy ]

  def index
    @catches = @log.catches.sort
  end

  def create
    @catch = @log.catches.new(catch_params)

    if @catch.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    catch = @log.catches.find(params[:id])
    catch.destroy

    @catches = @log.catches.sort
    render :index
  end

  private

  def catch_params
    params.require(:catch).permit(:fish_id, :quantity, :weight)
  end

  def set_log
    @log = @user.logs.find(params[:log_id])
  end

  def render_error
    render json: { errors: @catch.errors.full_messages },
           status: :unprocessable_entity
  end
end
