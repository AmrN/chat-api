# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    msg = current_user.messages.build(data["message"])
    # TODO: get current_user
    # msg.user = current_user
    if msg.save
      serialized = ActiveModel::SerializableResource.new(msg).as_json
      ActionCable.server.broadcast 'messages_channel', serialized
    end
  end
end
