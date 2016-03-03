class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :created_at, :updated_at
  has_many :subscriptions

  # has_many :messages

  #
  # class MessageSerializer < ActiveModel::Serializer
  #   attributes :content
  # end
end
