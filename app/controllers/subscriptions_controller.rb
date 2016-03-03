class SubscriptionsController < ApplicationController
  before_action :set_chatroom
  before_action :authenticate

  # GET /subscriptions
  def index
    @subscribers = @chatroom.subscribers
    render json: @subscribers
  end

  # POST /subscriptions
  def create
    @chatroom.subscribers << current_user
    render json: @chatroom
  end

  # DELETE /subscriptions/1
  def destroy
    @chatroom.subscribers.destroy(current_user)
    render json: @chatroom
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatroom
      @chatroom = Chatroom.find(params[:chatroom_id])
    end
end
