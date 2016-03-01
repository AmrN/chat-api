class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom
  validates :content, :user, :chatroom, presence: true
end
