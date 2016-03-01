class MessagesController < ApplicationController
  before_action :authenticate
  before_action :set_chatroom
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    @messages = @chatroom.messages.includes(:user)
    if params[:before_id]
      @messages = @messages.where('id < ?', params[:before_id])
    end

    render json: @messages.last(10)
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    @message = @chatroom.messages.new(message_params)
    @message.user = current_user
    if @message.save
      render json: @message, status: :created, location: [@chatroom, @message]
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private
    def set_chatroom
      @chatroom = Chatroom.find(params[:chatroom_id])
    end

    def set_message
      @message = @chatroom.messages.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:content)
    end
end
