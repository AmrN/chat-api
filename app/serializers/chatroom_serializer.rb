class ChatroomSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :subscribed

  def subscribed
    object.subscribers.include? current_user
  end
end
