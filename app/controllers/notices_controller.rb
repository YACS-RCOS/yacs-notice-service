class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :update, :destroy]

  before_action :allow_access

  # GET /notices
  def index
    @notices = Notice.current

    render json: @notices, each_serializer: NoticeSerializer
  end

  # GET /notices/1
  def show
    render json: @notice, each_serializer: NoticeSerializer
  end

  # POST /notices
  def create
    @notice = Notice.new(notice_params)
    if @notice.save
      render json: @notice, status: :created, location: @notice, each_serializer: NoticeSerializer
    else
      render json: @notice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notices/1
  def update
    if @notice.update(notice_params)
      render json: @notice, each_serializer: NoticeSerializer
    else
      render json: @notice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notices/1
  def destroy
    @notice.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notice
      @notice = Notice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def notice_params
      params.require(:notice).permit(:message, :alert_type, :start_date, :end_date)
    end

    def allow_access
      if session[:token].nil?
        render json: {}, status: 401
      end
    end
end
