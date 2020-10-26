class Api::V1::CatchesController < Api::V1::BaseController
  before_action :check_user_authorization
  before_action :set_log, only: [ :index, :create, :destroy ]

  def index
    set_index
  end

  def create
    @catch = @log.catches.new(catch_params)

    if @catch.save
      set_index
      render :index, status: :created
    else
      render_error
    end
  end

  def destroy
    catch = @log.catches.find(params[:id])
    catch.destroy

    set_index
    render :index
  end

  private

  def catch_params
    params.require(:catch).permit(:fish_id, :quantity, :weight)
  end

  def set_log
    @log = @user.logs.find(params[:log_id])
  end

  def set_index
    @catches = @log.catches.sort
  end

  def render_error
    render json: { errors: @catch.errors.full_messages },
           status: :unprocessable_entity
  end
end
