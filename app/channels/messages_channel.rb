# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    puts "\nmy data: #{data}"
    msg = Message.new(data["message"])
    # TODO: get current_user
    msg.user = User.first
    msg.save
    ActionCable.server.broadcast 'messages_channel', message: {content: msg.content}
  end
end
