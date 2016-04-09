class ChatroomSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :room_type, :one_to_one, :subscribed
  has_one :acquaintanceship
  def subscribed
    object.subscribers.include? current_user
  end

  def acquaintanceship
    object.acquaintanceships.find_by(person: current_user)
  end
end
