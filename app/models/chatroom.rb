class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :visitors, through: :messages, source: :user
  has_and_belongs_to_many :subscribers,
    join_table: "chatroom_subscriptions",
    class_name: "User"
  validates :name, presence: true
end
