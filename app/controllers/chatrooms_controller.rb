class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show, :update, :destroy, :subscribe]
  before_action :authenticate

  # GET /chatrooms
  def index
    if params[:search]
      @chatrooms = Chatroom.where("name LIKE ?", "%#{params[:search]}%")
    else
      @chatrooms = Chatroom.all
    end
    render json: @chatrooms
  end

  # GET /chatrooms/1
  def show
    render json: @chatroom
  end

  # POST /chatrooms
  def create
    @chatroom = Chatroom.new(chatroom_params)

    if @chatroom.save
      render json: @chatroom, status: :created, location: @chatroom
    else
      render json: @chatroom.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chatrooms/1
  def update
    if @chatroom.update(chatroom_params)
      render json: @chatroom
    else
      render json: @chatroom.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chatrooms/1
  def destroy
    @chatroom.destroy
    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatroom
      @chatroom = Chatroom.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chatroom_params
      params.require(:chatroom).permit(:name, :description)
    end
end
