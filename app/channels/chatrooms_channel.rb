# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom_#{params[:chatroom_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # msg = current_user.messages.build(data["message"])
    msg = Chatroom.find(params[:chatroom_id]).messages.build(data["message"])
    msg.user = current_user

    if msg.save
      serialized = ActiveModel::SerializableResource.new(msg).as_json
      ActionCable.server.broadcast "chatroom_#{params[:chatroom_id]}", serialized
    end
  end
end
